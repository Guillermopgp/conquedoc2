import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Configuración'),
        backgroundColor: Colors.cyan,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Ajustes',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.cyan[800]),
            ),
            SizedBox(height: 24),
            SwitchListTile(
              title: Text(
                'Modo Oscuro',
                style: TextStyle(fontSize: 18, color: Colors.cyan[800]),
              ),
              value: themeProvider.isDarkMode,
              onChanged: (bool value) {
                themeProvider.toggleTheme();
              },
              activeColor: Colors.cyan,
            ),
          ],
        ),
      ),
    );
  }
}
