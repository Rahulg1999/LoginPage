import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_page/Login/login_screen.dart';
import 'package:login_page/SignUp/signup_screen.dart';
import 'package:login_page/first_screen.dart';
import 'package:login_page/welcome_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      routes: {
        'firstScreen':(context)=> const FirstScreen(),
        'loginScreen':(context)=> const LoginScreen(),
        'signupScreen':(context)=>const SignUpScreen(title: 'Ghost'),
        'welcomeScreen':(context)=> const WelcomeScreen()
      },
      home: const FirstScreen(),
    );
  }
}

