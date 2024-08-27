import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class FichaMedicaPage extends StatefulWidget {
  @override
  _FichaMedicaPageState createState() => _FichaMedicaPageState();
}

class _FichaMedicaPageState extends State<FichaMedicaPage> {
  final _formKey = GlobalKey<FormState>();
  String _nombreCompleto = '';
  int _edad = 0;
  String _sexo = '';
  String _grupoSanguineo = '';
  String _enfermedadesBase = '';
  bool _donanteOrganos = false;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Ficha Médica'),
        backgroundColor: Colors.cyan,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Center(
                child: Icon(Icons.medical_services, size: 100, color: Colors.cyan),
              ),
              SizedBox(height: 20),
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        initialValue: userProvider.nombreCompleto,
                        decoration: InputDecoration(
                          labelText: 'Nombre Completo',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                          prefixIcon: Icon(Icons.person, color: Colors.cyan),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.cyan, width: 2.0),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        onSaved: (value) {
                          _nombreCompleto = value!;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        initialValue: userProvider.edad.toString(),
                        decoration: InputDecoration(
                          labelText: 'Edad',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                          prefixIcon: Icon(Icons.calendar_today, color: Colors.cyan),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.cyan, width: 2.0),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          _edad = int.parse(value!);
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        initialValue: userProvider.sexo,
                        decoration: InputDecoration(
                          labelText: 'Sexo',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                          prefixIcon: Icon(Icons.transgender, color: Colors.cyan),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.cyan, width: 2.0),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        onSaved: (value) {
                          _sexo = value!;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        initialValue: userProvider.grupoSanguineo,
                        decoration: InputDecoration(
                          labelText: 'Grupo Sanguíneo',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                          prefixIcon: Icon(Icons.bloodtype, color: Colors.cyan),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.cyan, width: 2.0),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        onSaved: (value) {
                          _grupoSanguineo = value!;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        initialValue: userProvider.enfermedadesBase,
                        decoration: InputDecoration(
                          labelText: 'Enfermedades Base',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                          prefixIcon: Icon(Icons.local_hospital, color: Colors.cyan),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.cyan, width: 2.0),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        onSaved: (value) {
                          _enfermedadesBase = value!;
                        },
                      ),
                      SizedBox(height: 16),
                      CheckboxListTile(
                        title: Text('Donante de Órganos'),
                        value: _donanteOrganos,
                        onChanged: (value) {
                          setState(() {
                            _donanteOrganos = value!;
                          });
                        },
                        activeColor: Colors.cyan,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            userProvider.updateFichaMedica(
                              _nombreCompleto,
                              _edad,
                              _sexo,
                              _grupoSanguineo,
                              _enfermedadesBase,
                              _donanteOrganos,
                            );
                            Navigator.pop(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan,
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0), // Radio pequeño para bordes rectangulares
                          ),
                        ),
                        child: Text(
                          'Guardar',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
