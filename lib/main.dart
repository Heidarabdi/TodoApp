import 'package:flutter/material.dart';
import 'package:todo_app/screens/home.dart';
import 'package:todo_app/screens/login.dart';
import 'package:todo_app/screens/profile_page.dart';

// firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_app/screens/reset_password.dart';
import 'package:todo_app/screens/signup.dart';
import 'firebase_options.dart';


// main
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
// MyApp

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  const LogInScreen(),
      title: 'Todo App',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
        
      ),

      routes: {
        '/home': (context) => const HomeScreen(),
        '/profile': (context) => const ProfilePage(),
        '/login': (context) => const LogInScreen(),
        '/signup': (context) =>  SignUpScreen(),
        '/forgot': (context) =>  ResetPasswordScreen(),
      },
    );
  }
}
