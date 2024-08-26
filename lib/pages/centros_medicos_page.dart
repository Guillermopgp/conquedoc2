import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CentrosMedicosPage extends StatefulWidget {
  @override
  _CentrosMedicosPageState createState() => _CentrosMedicosPageState();
}

class _CentrosMedicosPageState extends State<CentrosMedicosPage> {
  List<dynamic> _centrosMedicos = [];

  @override
  void initState() {
    super.initState();
    _fetchNearbyMedicalCenters();
  }

  void _fetchNearbyMedicalCenters() async {
    final response = await http.get(Uri.parse('https://api.example.com/nearby-medical-centers'));
    if (response.statusCode == 200) {
      setState(() {
        _centrosMedicos = json.decode(response.body);
      });
    } else {
      throw 'Failed to load medical centers';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Centros Médicos Cercanos'),
      ),
      body: ListView.builder(
        itemCount: _centrosMedicos.length,
        itemBuilder: (context, index) {
          final center = _centrosMedicos[index];
          return ListTile(
            title: Text(center['name']),
            subtitle: Text(center['address']),
          );
        },
      ),
    );
  }
}