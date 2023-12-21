import 'package:flutter/material.dart';
import 'package:todo_app/screens/home.dart';

// main

void main() {
  runApp(const MyApp());
}

// MyApp

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      title: 'Todo App',
      theme: ThemeData(
        useMaterial3: true,
        
      ),
    );
  }
}
