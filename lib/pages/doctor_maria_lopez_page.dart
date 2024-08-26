import 'package:flutter/material.dart';

class DoctorMariaLopezPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dra. María López'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Center(
              child: Image.asset('assets/doctor1.png', width: 100, height: 100),
            ),
            SizedBox(height: 16),
            _buildCard('Datos Personales', 'Nombre: Dra. María López\nEdad: 38\nHorarios de Atención: 10 AM - 6 PM\nProcedimientos: Kinesiología, Terapia Física, etc.'),
            SizedBox(height: 10),
            _buildCard('Formación y Diplomados', 'Universidad de Santiago\nDiplomado en Kinesiología'),
            SizedBox(height: 10),
            _buildCard('Opinión de Paciente 1', 'Muy buena profesional, me ayudó mucho.'),
            SizedBox(height: 10),
            _buildCard('Opinión de Paciente 2', 'Excelente trato y conocimiento.'),
            SizedBox(height: 10),
            _buildCard('Opinión de Paciente 3', 'Recomendada al 100%.'),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String title, String content) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(content),
          ],
        ),
      ),
    );
  }
}