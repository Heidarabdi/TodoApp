import 'package:firebase_auth/firebase_auth.dart';
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
      title: 'Todo App',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          print('Connection state: ${snapshot.connectionState}');
          if (snapshot.connectionState == ConnectionState.active) {
            final User? user = snapshot.data;
            if (user == null) {
              return const LogInScreen();
            } else {
              return const HomeScreen();
            }
          } else if(snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return const LogInScreen();
          }
        },
      ),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/profile': (context) => const ProfilePage(),
        '/login': (context) => const LogInScreen(),
        '/signup': (context) => SignUpScreen(),
        '/forgot': (context) => ResetPasswordScreen(),
      },
    );
  }
}