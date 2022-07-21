import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ghost welcome'),
      ),
      body:  Center(
        child: Column(
          children: [
            const Text(
              "Welcome to Ghost app",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 30, color: Colors.red),
            ),
            ElevatedButton(
                onPressed: () async {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushNamedAndRemoveUntil(context, "firstScreen", (Route<dynamic> route) => false);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("You've signed out successfully"),
                  ));
                },
                child: Text('Signout'.toUpperCase()))
          ],
        ),
      ),
    );
  }
}
