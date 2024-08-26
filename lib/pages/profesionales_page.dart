import 'package:flutter/material.dart';

class ProfesionalesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profesionales'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            _buildProfessionalCard(context, 'assets/doctor3.png', 'Dr. Juan Pérez', 'Cardiología', '/doctorJuanPerez'),
            SizedBox(height: 10),
            _buildProfessionalCard(context, 'assets/doctor1.png', 'Dra. María López', 'Kinesiología', '/doctorMariaLopez'),
            SizedBox(height: 10),
            _buildProfessionalCard(context, 'assets/doctor2.png', 'Dr. Carlos García', 'Medicina General', '/doctorCarlosGarcia'),
          ],
        ),
      ),
    );
  }

  Widget _buildProfessionalCard(BuildContext context, String avatarPath, String name, String specialty, String route) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Card(
        elevation: 4,
        child: ListTile(
          leading: Image.asset(avatarPath, width: 40, height: 40), // Adjusted size
          title: Text(name),
          subtitle: Text(specialty),
        ),
      ),
    );
  }
}