import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'profesionales_page.dart';

class EspecialidadesPage extends StatefulWidget {
  @override
  _EspecialidadesPageState createState() => _EspecialidadesPageState();
}

class _EspecialidadesPageState extends State<EspecialidadesPage> {
  List<dynamic> especialidades = [];
  List<dynamic> filteredResultados = [];
  TextEditingController _searchController = TextEditingController();
  bool isLoading = false;
  List<String> especialidadesAutocomplete = [
    'Dental', 'Radiología', 'Medicina General',
    'Kinesiología', 'Maternidad', 'Cardiología'
  ];

  @override
  void initState() {
    super.initState();
    loadEspecialidades();
  }

  Future<void> loadEspecialidades() async {
    setState(() {
      isLoading = true;
    });
    try {
      String jsonString = await rootBundle.loadString('assets/data/especialidades.json');
      final jsonResponse = json.decode(jsonString);
      setState(() {
        especialidades = jsonResponse['especialidades'];
      });
    } catch (e) {
      print('Error al cargar Especialidades: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar Especialidades')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _filterEspecialidades() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredResultados = especialidades.where((especialidad) {
        final nombreEspecialidad = especialidad['nombre'].toLowerCase();
        return nombreEspecialidad.contains(query);
      }).expand((especialidad) {
        return (especialidad['establecimientos'] as List).expand((establecimiento) {
          return (establecimiento['profesionales'] as List).map((profesional) {
            return {
              'especialidad': especialidad['nombre'],
              'establecimiento': establecimiento['nombre'],
              'profesional': profesional,
            };
          });
        });
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Especialidades'),
        backgroundColor: Colors.cyan,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text == '') {
                        return const Iterable<String>.empty();
                      }
                      return especialidadesAutocomplete.where((String option) {
                        return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                      });
                    },
                    onSelected: (String selection) {
                      _searchController.text = selection;
                    },
                    fieldViewBuilder: (BuildContext context, TextEditingController fieldTextEditingController,
                        FocusNode fieldFocusNode, VoidCallback onFieldSubmitted) {
                      _searchController = fieldTextEditingController;
                      return TextField(
                        controller: _searchController,
                        focusNode: fieldFocusNode,
                        decoration: InputDecoration(
                          labelText: 'Buscar especialidad',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _filterEspecialidades,
                  child: Text('Buscar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator(color: Colors.cyan))
                : filteredResultados.isEmpty
                ? Center(child: Text('No se encontraron resultados', style: TextStyle(fontSize: 18)))
                : ListView.builder(
              itemCount: filteredResultados.length,
              itemBuilder: (context, index) {
                final resultado = filteredResultados[index];
                return _buildListItem(
                  context,
                  Icons.medical_services,
                  '${resultado['profesional']['nombre']} - ${resultado['establecimiento']}',
                  resultado['especialidad'],
                  resultado['profesional'],
                  resultado['establecimiento'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(BuildContext context, IconData icon, String title, String especialidad, Map<String, dynamic> profesional, String establecimiento) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.cyan,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text(especialidad),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfesionalesPage(
                profesional: profesional,
                especialidad: especialidad,
                establecimiento: establecimiento,
              ),
            ),
          );
        },
      ),
    );
  }
}