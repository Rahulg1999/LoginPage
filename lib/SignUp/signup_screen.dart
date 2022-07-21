import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();
  late String name;
  late String email;
  late String password;
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;

  bool isValidEntries() {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please enter name"),
      ));
      return false;
    } else if (emailController.text.isEmpty ||
        !regex.hasMatch(emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please enter correct email'),
      ));
      return false;
    } else if (passwordController.text.isEmpty ||
        retypePasswordController.text.isEmpty ||
        passwordController.text.length <
            9|| retypePasswordController.text.length < 9) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please enter password'),
      ));
      return false;
    } else if (passwordController.text != retypePasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Both password should be same'),
      ));
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Expanded(
            child: !showSpinner
                ? Column(
              children: [
                const Text(
                  'Signup Screen',
                  style: TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Name',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                    validator: (value) {
                      return value!.isEmpty ? 'Please enter name' : null;
                    },
                    controller: nameController,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Your name',
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
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Retype Password',
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
                    controller: retypePasswordController,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Retype your password',
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
                        final newUser =
                        await _auth.createUserWithEmailAndPassword(
                            email: email, password: password);

                        if (newUser != null) {
                          Navigator.pushNamed(context, 'welcomeScreen');
                          setState(() {
                            showSpinner = false;
                          });
                        }
                      } on FirebaseAuthException
                      catch (e) {
                        print(e);
                      }
                    },
                    child: Text('Register'.toUpperCase()))
              ],
            )
                : const Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}
