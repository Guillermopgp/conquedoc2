import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _name = 'Guillermo';
  String _address = 'Dirección de ejemplo';
  String _phoneNumber = '123456789';
  String _nombreCompleto = 'Guillermo';
  int _edad = 30;
  String _sexo = 'Masculino';
  String _grupoSanguineo = 'O+';
  String _enfermedadesBase = 'Ninguna';
  bool _donanteOrganos = false;

  String get name => _name;
  String get address => _address;
  String get phoneNumber => _phoneNumber;
  String get nombreCompleto => _nombreCompleto;
  int get edad => _edad;
  String get sexo => _sexo;
  String get grupoSanguineo => _grupoSanguineo;
  String get enfermedadesBase => _enfermedadesBase;
  bool get donanteOrganos => _donanteOrganos;

  void updateUser(String name, String address, String phoneNumber) {
    _name = name;
    _address = address;
    _phoneNumber = phoneNumber;
    notifyListeners();
  }

  void updateFichaMedica(String nombreCompleto, int edad, String sexo, String grupoSanguineo, String enfermedadesBase, bool donanteOrganos) {
    _nombreCompleto = nombreCompleto;
    _edad = edad;
    _sexo = sexo;
    _grupoSanguineo = grupoSanguineo;
    _enfermedadesBase = enfermedadesBase;
    _donanteOrganos = donanteOrganos;
    notifyListeners();
  }
}