// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Translator',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        primaryColor: Colors.orange[200],
      ),
      home: HomePage(title: 'Translator'),
    );
  }
}

