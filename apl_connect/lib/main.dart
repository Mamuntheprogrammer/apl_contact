import 'package:flutter/material.dart';
import 'screens/splash_screen.dart'; // Import the splash screen
import 'screens/home_screen.dart'; // Keep your HomeScreen import

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
      home: const SplashScreen(), // Show SplashScreen first
      debugShowCheckedModeBanner: false,
      routes: {
        '/home':
            (context) => const HomeScreen(), // Add this route for redirection
      },
    );
  }
}
