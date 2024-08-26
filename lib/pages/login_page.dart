import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _rememberMe = false;
  bool _isLoading = false;
  bool _obscurePassword = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _loadRememberedCredentials();
  }

  Future<void> _loadRememberedCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool rememberMe = prefs.getBool('rememberMe') ?? false;
    if (rememberMe) {
      String? email = prefs.getString('rememberedEmail');
      if (email != null) _emailController.text = email;
      setState(() {
        _rememberMe = rememberMe;
      });
    }
  }

  Future<void> _saveCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_rememberMe) {
      await prefs.setString('rememberedEmail', _emailController.text);
    } else {
      await prefs.remove('rememberedEmail');
    }
    await prefs.setBool('rememberMe', _rememberMe);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Iniciar Sesión')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Correo electrónico',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => _validateEmail(value),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
                obscureText: _obscurePassword,
                validator: (value) => _validatePassword(value),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: _rememberMe,
                    onChanged: (bool? value) => setState(() => _rememberMe = value ?? false),
                  ),
                  const Text('Recordar correo electrónico'),
                ],
              ),
              const SizedBox(height: 16),
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: _loginUser,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                  backgroundColor: Colors.cyan,
                ),
                child: const Text('Iniciar Sesión'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/register'),
                child: const Text('¿No tienes una cuenta? Regístrate'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _loginUser() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      if (userCredential.user != null) {
        await _saveCredentials();
        Navigator.pushReplacementNamed(context, '/dashboard');
      }
    } on FirebaseAuthException catch (e) {
      _handleFirebaseAuthError(e);
    } catch (e) {
      _showErrorMessage('Ocurrió un error inesperado: $e');
    }

    setState(() => _isLoading = false);
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingresa tu correo electrónico';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Por favor, ingresa un correo electrónico válido';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingresa tu contraseña';
    }
    if (value.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }
    return null;
  }

  void _handleFirebaseAuthError(FirebaseAuthException e) {
    String errorMessage;
    switch (e.code) {
      case 'user-not-found':
        errorMessage = 'No se encontró ningún usuario con ese correo electrónico.';
        break;
      case 'wrong-password':
        errorMessage = 'Contraseña incorrecta.';
        break;
      case 'invalid-email':
        errorMessage = 'El correo electrónico proporcionado no es válido.';
        break;
      case 'user-disabled':
        errorMessage = 'Esta cuenta de usuario ha sido deshabilitada.';
        break;
      default:
        errorMessage = 'Ocurrió un error durante el inicio de sesión: ${e.message}';
    }
    _showErrorMessage(errorMessage);
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}