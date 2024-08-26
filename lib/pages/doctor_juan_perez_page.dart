import 'package:flutter/material.dart';

class DoctorJuanPerezPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dr. Juan Pérez'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Center(
              child: Image.asset('assets/doctor3.png', width: 100, height: 100),
            ),
            SizedBox(height: 16),
            _buildCard('Datos Personales', 'Nombre: Dr. Juan Pérez\nEdad: 45\nHorarios de Atención: 9 AM - 5 PM\nProcedimientos: Cardiología, ECG, etc.'),
            SizedBox(height: 10),
            _buildCard('Formación y Diplomados', 'Universidad de Chile\nDiplomado en Cardiología'),
            SizedBox(height: 10),
            _buildCard('Opinión de  Allison Mandel', 'Excelente doctor, muy profesional, me controlo lo necesario para la buena recepcion en mi operacion a tajo abierto.'),
            SizedBox(height: 10),
            _buildCard('Opinión de Paciente 2', 'Muy atento y claro en sus explicaciones.'),
            SizedBox(height: 10),
            _buildCard('Opinión de Paciente 3', 'Gran experiencia y trato humano.'),
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