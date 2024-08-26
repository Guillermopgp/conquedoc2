import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CardiologiaOptionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cardiología - Opciones'),
      ),
      body: ListView(
        children: <Widget>[
          _buildOptionCard('Opción 1', 'https://www.redclinica.cl/plantilla/especialidades/cardiologia.aspx'),
          _buildOptionCard('Opción 2', 'https://www.example.com/option2'),
          _buildOptionCard('Opción 3', 'https://www.example.com/option3'),
        ],
      ),
    );
  }

  Widget _buildOptionCard(String title, String url) {
    return GestureDetector(
      onTap: () => _launchURL(url),
      child: Card(
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(title, style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}