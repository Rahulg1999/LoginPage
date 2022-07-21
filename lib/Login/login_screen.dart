import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isValidEntries() {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (emailController.text.isEmpty || !regex.hasMatch(emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please enter correct email'),
      ));
      return false;
    } else if (passwordController.text.isEmpty ||
        passwordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please enter correct password'),
      ));
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ghost Login'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Expanded(
          child: SingleChildScrollView(
            child: !showSpinner
                ? Column(
                    children: [
                      const Text(
                        'Login Screen',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Email',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                          validator: (value) {
                            return value!.isEmpty ? 'Please enter email' : null;
                          },
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter Your Email',
                          ),
                          autofocus: true,
                          onFieldSubmitted: (value) {
                            /*if (formKey.currentState.validate()) {
                          } else {
                            setState(() {
                              autoValidate = true;
                            });
                          }*/
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Password',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                          validator: (value) {
                            return value!.isEmpty
                                ? 'Please enter password'
                                : null;
                          },
                          controller: passwordController,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter Your Password',
                          ),
                          autofocus: true,
                          onFieldSubmitted: (value) {
                            /*if (formKey.currentState.validate()) {
                          } else {
                            setState(() {
                              autoValidate = true;
                            });
                          }*/
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            if (!isValidEntries()) return;
                            setState(() {
                              showSpinner = true;
                            });
                            email = emailController.text.toString();
                            password = passwordController.text.toString();
                            try {
                              final user =
                                  await _auth.signInWithEmailAndPassword(
                                      email: email, password: password);
                              if (user != null) {
                                Navigator.pushNamed(context, 'welcomeScreen');
                                setState(() {
                                  showSpinner = false;
                                });
                              }
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                setState(() {
                                  showSpinner = false;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text('No user found for that email.'),
                                ));
                              } else if (e.code == 'wrong-password') {
                                setState(() {
                                  showSpinner = false;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text('wrong password given'),
                                ));
                              }
                            }
                          },
                          child: Text('Login'.toUpperCase()))
                    ],
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}
