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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Center(
                child: Icon(Icons.medical_services, size: 100, color: Colors.blue),
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
                        decoration: InputDecoration(labelText: 'Nombre Completo'),
                        onSaved: (value) {
                          _nombreCompleto = value!;
                        },
                      ),
                      TextFormField(
                        initialValue: userProvider.edad.toString(),
                        decoration: InputDecoration(labelText: 'Edad'),
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          _edad = int.parse(value!);
                        },
                      ),
                      TextFormField(
                        initialValue: userProvider.sexo,
                        decoration: InputDecoration(labelText: 'Sexo'),
                        onSaved: (value) {
                          _sexo = value!;
                        },
                      ),
                      TextFormField(
                        initialValue: userProvider.grupoSanguineo,
                        decoration: InputDecoration(labelText: 'Grupo Sanguíneo'),
                        onSaved: (value) {
                          _grupoSanguineo = value!;
                        },
                      ),
                      TextFormField(
                        initialValue: userProvider.enfermedadesBase,
                        decoration: InputDecoration(labelText: 'Enfermedades Base'),
                        onSaved: (value) {
                          _enfermedadesBase = value!;
                        },
                      ),
                      CheckboxListTile(
                        title: Text('Donante de Órganos'),
                        value: userProvider.donanteOrganos,
                        onChanged: (value) {
                          setState(() {
                            _donanteOrganos = value!;
                          });
                        },
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
                        child: Text('Guardar'),
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