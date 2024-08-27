import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class CentrosMedicosPage extends StatefulWidget {
  @override
  _CentrosMedicosPageState createState() => _CentrosMedicosPageState();
}

class _CentrosMedicosPageState extends State<CentrosMedicosPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> centrosMedicos = [];
  bool isLoading = false;
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await _determinePosition();
      setState(() {
        _currentPosition = position;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al obtener la ubicación: $e')),
      );
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Los servicios de ubicación están desactivados.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Los permisos de ubicación fueron denegados');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Los permisos de ubicación están permanentemente denegados, no podemos solicitar permisos.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> _searchPlaces(String query) async {
    if (_currentPosition == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ubicación no disponible. Intente de nuevo.')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse(
          'https://nominatim.openstreetmap.org/search.php?q=$query&format=jsonv2&lat=${_currentPosition!.latitude}&lon=${_currentPosition!.longitude}&limit=5'));

      if (response.statusCode == 200) {
        final List<dynamic> places = json.decode(response.body);
        setState(() {
          centrosMedicos = places.map((place) => {
            'nombre': place['display_name'],
            'lat': double.parse(place['lat']),
            'lon': double.parse(place['lon']),
          }).toList();
        });
      } else {
        throw Exception('Failed to load places');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al buscar lugares: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _abrirMapa(double lat, double lon) async {
    final url = 'https://www.openstreetmap.org/?mlat=$lat&mlon=$lon&zoom=15';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo abrir el mapa $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Centros Médicos'),
        backgroundColor: Colors.cyan,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Buscar Lugares', style: TextStyle(fontSize: 24, color: Colors.cyan)),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Buscar lugares...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan, width: 2.0),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      prefixIcon: Icon(Icons.search, color: Colors.cyan),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if (_searchController.text.isNotEmpty) {
                      _searchPlaces(_searchController.text);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  child: Text(
                    'Buscar',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator(color: Colors.cyan))
                  : ListView.builder(
                itemCount: centrosMedicos.length,
                itemBuilder: (context, index) {
                  final centro = centrosMedicos[index];
                  return _buildListItem(
                    context,
                    'assets/centros_medicos.png',
                    centro['nombre'],
                    '${centro['lat']}, ${centro['lon']}',
                    centro['lat'],
                    centro['lon'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, String assetPath, String nombre, String coordenadas, double lat, double lon) {
    return GestureDetector(
      onTap: () => _abrirMapa(lat, lon),
      child: Card(
        elevation: 4,
        child: ListTile(
          leading: Image.asset(assetPath, width: 50, height: 50),
          title: Text(nombre, style: TextStyle(fontSize: 18)),
          subtitle: Text(coordenadas),
          trailing: Icon(Icons.map, color: Colors.cyan),
        ),
      ),
    );
  }
}
