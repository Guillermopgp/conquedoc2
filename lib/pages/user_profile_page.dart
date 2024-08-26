import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _address = '';
  String _phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: userProvider.name,
                decoration: InputDecoration(labelText: 'Nombre'),
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                initialValue: userProvider.address,
                decoration: InputDecoration(labelText: 'Dirección'),
                onSaved: (value) {
                  _address = value!;
                },
              ),
              TextFormField(
                initialValue: userProvider.phoneNumber,
                decoration: InputDecoration(labelText: 'Número de Teléfono'),
                onSaved: (value) {
                  _phoneNumber = value!;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    userProvider.updateUser(_name, _address, _phoneNumber);
                    Navigator.pop(context);
                  }
                },
                child: Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}