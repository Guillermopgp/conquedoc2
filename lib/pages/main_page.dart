import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Tasks App'),
      ),
      body: Center(
        child: Text('Welcome to Home Tasks App'),
      ),
    );
  }
}