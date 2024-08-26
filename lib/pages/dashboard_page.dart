import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../providers/user_provider.dart';
import 'centros_medicos_page.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String _formattedDate = '';

  @override
  void initState() {
    super.initState();
    _formattedDate = DateFormat.yMMMMd('en_US').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('ConQueDoc?'),
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage('assets/avatar.png'), // Ensure you have an avatar image in assets
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Bienvenido, ${userProvider.name}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        userProvider.address,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        userProvider.phoneNumber,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Perfil'),
                  onTap: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Configuracion'),
                  onTap: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                ),
              ],
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Cerrar Sesión'),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.clear();
                Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Tu App de Gestión de Salud', style: TextStyle(fontSize: 24)),
            SizedBox(height: 16),
            Text(_formattedDate, style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: <Widget>[
                  _buildGridItem(context, 'assets/ficha_medica.png', 'Ficha Médica', '/fichaMedica'),
                  _buildGridItem(context, 'assets/centros_medicos.png', 'Centros Médicos', 'centros_medicos'),
                  _buildGridItem(context, 'assets/especialidades.png', 'Especialidades', '/especialidades'),
                  _buildGridItem(context, 'assets/profesionales.png', 'Profesionales', '/profesionales'),
                  _buildGridItem(context, 'assets/coberturas.png', 'Coberturas', '/coberturas', centerIcon: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, String assetPath, String title, String route, {bool centerIcon = false}) {
    return GestureDetector(
      onTap: () {
        if (route == 'centros_medicos') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CentrosMedicosPage()),
          );
        } else {
          Navigator.pushNamed(context, route);
        }
      },
      child: Card(
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            centerIcon
                ? Center(child: Image.asset(assetPath, width: 50, height: 50))
                : Image.asset(assetPath, width: 50, height: 50),
            SizedBox(height: 16),
            Text(title, style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}