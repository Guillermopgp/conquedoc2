import 'package:flutter/material.dart';
import 'dart:math';

class ProfesionalesPage extends StatelessWidget {
  final Map<String, dynamic> profesional;
  final String especialidad;
  final String establecimiento;

  ProfesionalesPage({
    required this.profesional,
    required this.especialidad,
    required this.establecimiento,
  });

  @override
  Widget build(BuildContext context) {
    bool isFemale = profesional['nombre'].toLowerCase().contains('dra.');
    String imageAsset = isFemale ? 'assets/doctor1.png' : 'assets/doctor${Random().nextInt(2) + 2}.png';

    return Scaffold(
      appBar: AppBar(
        title: Text(profesional['nombre']),
        backgroundColor: Colors.cyan,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              color: Colors.cyan.shade50,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage(imageAsset),
                  ),
                  SizedBox(height: 16),
                  Text(
                    profesional['nombre'],
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    especialidad,
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            _buildCard('Datos Personales', [
              'Especialidad: $especialidad',
              'Establecimiento: $establecimiento',
              'Experiencia: ${profesional['experiencia']}',
              'ID: ${profesional['id']}',
            ]),
            _buildCard('Subespecialidad', [
              profesional['subespecialidad'] ?? profesional['especialidad'] ?? 'No especificada',
            ]),
            _buildCard('Formación y Diplomados', [
              'Universidad: ${profesional['universidad'] ?? 'Universidad Autonoma'}',
              'Diplomados: ${profesional['diplomados'] ?? 'Información no disponible'}',
            ]),
            _buildCard('Horarios de Atención', [
              profesional['horarios'] ?? 'Horarios no especificados',
            ]),
            _buildCard('Procedimientos', [
              ...(profesional['procedimientos'] as List<String>? ?? ['Información no disponible']),
            ]),
            _buildCard('Opiniones de Pacientes', [
              'Opinión 1: Excelente profesional, muy recomendado.',
              'Opinión 2: Atención de calidad y trato amable.',
              'Opinión 3: Muy buen doctor, explicaciones claras.',
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String title, List<String> content) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyan[800],
                ),
              ),
              SizedBox(height: 12),
              ...content.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  item,
                  style: TextStyle(fontSize: 16),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}