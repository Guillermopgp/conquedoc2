import 'package:flutter/material.dart';

class DoctorCarlosGarciaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dr. Carlos García'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Center(
              child: Image.asset('assets/doctor2.png', width: 100, height: 100),
            ),
            SizedBox(height: 16),
            _buildCard('Datos Personales', 'Nombre: Dr. Carlos García\nEdad: 50\nHorarios de Atención: 8 AM - 4 PM\nProcedimientos: Medicina General, Consulta, etc.'),
            SizedBox(height: 10),
            _buildCard('Formación y Diplomados', 'Universidad Católica\nDiplomado en Medicina General'),
            SizedBox(height: 10),
            _buildCard('Opinión de Paciente 1', 'Muy buen doctor, muy atento.'),
            SizedBox(height: 10),
            _buildCard('Opinión de Paciente 2', 'Excelente profesional, muy recomendado.'),
            SizedBox(height: 10),
            _buildCard('Opinión de Paciente 3', 'Gran experiencia y trato amable.'),
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