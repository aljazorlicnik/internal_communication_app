import 'package:flutter/material.dart';
import 'pages/login.dart'; // Import your login page file
import 'pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Internal Communication App',
      theme: ThemeData(
        // Define your app's theme here
      ),
      home: LoginPage(), // Set your login page as the initial route
      routes: {
        '/home': (context) => HomePage(),
      },
    );
  }
}
