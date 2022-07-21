import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              const Text(
                'Ghost Inc.',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 50),
              ),
              SizedBox(width:100,child: ElevatedButton(onPressed: (){
                Navigator.pushNamed(context, 'loginScreen');
              }, child: Text('Login'.toUpperCase()))),
              SizedBox(width:100,child: ElevatedButton(onPressed: (){
                Navigator.pushNamed(context, 'signupScreen');
              }, child: Text('SignUp'.toUpperCase()))),
            ],
          ),
      ),
    );
  }
}
