import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
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
    _formattedDate = DateFormat.yMMMMd('es_ES').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('ConQueDoc?'),
        backgroundColor: Colors.cyan,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(userProvider.name),
              accountEmail: Text(userProvider.address),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/avatar.png'),
              ),
              decoration: BoxDecoration(
                color: Colors.cyan,
              ),
            ),
            ListTile(
              leading: Icon(Icons.person, color: Colors.cyan),
              title: Text('Perfil'),
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.cyan),
              title: Text('Configuración'),
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.cyan),
              title: Text('Cerrar Sesión'),
              onTap: () {
                // Implementar lógica de cierre de sesión
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Tu App de Gestión de Salud',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.cyan[800]),
              ),
              SizedBox(height: 16),
              Text(_formattedDate, style: TextStyle(fontSize: 18, color: Colors.grey[600])),
              SizedBox(height: 24),
              _buildListItem(context, 'assets/ficha_medica.png', 'Ficha Médica', '/fichaMedica'),
              _buildListItem(context, 'assets/centros_medicos.png', 'Centros Médicos', '/centrosMedicos'),
              _buildListItem(context, 'assets/especialidades.png', 'Especialidades', '/especialidades'),
              _buildListItem(context, 'assets/coberturas.png', 'Coberturas', '/coberturas'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, String assetPath, String title, String route) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, route);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Image.asset(assetPath, width: 50, height: 50),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.cyan),
            ],
          ),
        ),
      ),
    );
  }
}