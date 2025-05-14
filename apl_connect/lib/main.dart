import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // Correct file as per your structure

void main() {
  runApp(const ContactApp());
}

class ContactApp extends StatelessWidget {
  const ContactApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Office Contact Directory',
      theme: ThemeData(primarySwatch: Colors.blueGrey, useMaterial3: true),
      home: const HomeScreen(), // Starts at home_screen.dart
      debugShowCheckedModeBanner: false,
    );
  }
}
