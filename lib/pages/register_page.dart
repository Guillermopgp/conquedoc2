import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Correo electrónico',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'Confirmar contraseña',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock_outline),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _registerUser,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                backgroundColor: Colors.blue,
              ),
              child: const Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _registerUser() async {
    if (!_validateInputs()) return;

    setState(() {
      _isLoading = true;
    });

    print("Iniciando proceso de registro"); // Log para depuración

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      print("Usuario creado exitosamente en Firebase Auth");

      if (userCredential.user != null) {
        await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
          'email': _emailController.text.trim(),
          'createdAt': FieldValue.serverTimestamp(),
        });
        // Enviar correo de verificación
        print("Enviando correo de verificación");
        await userCredential.user!.sendEmailVerification();

        print("Correo de verificación enviado");
        await FirebaseAuth.instance.signOut();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuario registrado. Por favor, verifica tu correo electrónico.')),
        );
        Navigator.of(context).pushReplacementNamed('/login');
      }

    } on FirebaseAuthException catch (e) {
      _handleFirebaseAuthError(e);
    } catch (e) {
      _showErrorMessage('Ocurrió un error inesperado: $e');
    }

    setState(() {
      _isLoading = false;
    });

    print("Proceso de registro finalizado");
  }

  bool _validateInputs() {
    if (_emailController.text.trim().isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      _showErrorMessage('Por favor, completa todos los campos.');
      return false;
    }

    if (!_isValidEmail(_emailController.text.trim())) {
      _showErrorMessage('Por favor, ingresa un correo electrónico válido.');
      return false;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      _showErrorMessage('Las contraseñas no coinciden.');
      return false;
    }

    if (_passwordController.text.length < 6) {
      _showErrorMessage('La contraseña debe tener al menos 6 caracteres.');
      return false;
    }

    return true;
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  void _handleFirebaseAuthError(FirebaseAuthException e) {
    String errorMessage;
    switch (e.code) {
      case 'weak-password':
        errorMessage = 'La contraseña proporcionada es demasiado débil.';
        break;
      case 'email-already-in-use':
        errorMessage = 'Ya existe una cuenta con este correo electrónico.';
        break;
      case 'invalid-email':
        errorMessage = 'El correo electrónico proporcionado no es válido.';
        break;
      default:
        errorMessage = 'Ocurrió un error durante el registro: ${e.message}';
    }
    _showErrorMessage(errorMessage);
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}