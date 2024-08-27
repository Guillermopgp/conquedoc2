import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'providers/task_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/user_provider.dart';
import 'pages/register_page.dart';
import 'pages/login_page.dart';
import 'pages/dashboard_page.dart';
import 'pages/user_profile_page.dart';
import 'pages/settings_page.dart';
import 'pages/ficha_medica_page.dart';
import 'pages/centros_medicos_page.dart';
import 'pages/especialidades_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Inicializar los datos de localización
  await initializeDateFormatting('es_ES', null);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TaskProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'ConQueDoctor',
            theme: themeProvider.themeData,
            home: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasData) {
                  return DashboardPage();
                } else {
                  return LoginPage();
                }
              },
            ),
            routes: {
              '/register': (context) => RegisterPage(),
              '/login': (context) => LoginPage(),
              '/dashboard': (context) => DashboardPage(),
              '/profile': (context) => UserProfilePage(),
              '/settings': (context) => SettingsPage(),
              '/fichaMedica': (context) => FichaMedicaPage(),
              '/centrosMedicos': (context) => CentrosMedicosPage(),
              '/especialidades': (context) => EspecialidadesPage(),
            },
          );
        },
      ),
    );
  }
}