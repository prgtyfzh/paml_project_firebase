import 'package:flutter/material.dart';

import '../controller/auth_controller.dart';
import '../model/user_model.dart';
import 'login.dart';

class Register extends StatelessWidget {
  Register({super.key});

  final form = GlobalKey<FormState>();
  final authController = AuthController();

  @override
  Widget build(BuildContext context) {
    String? name;
    String? email;
    String? password;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                ' Name',
                style: TextStyle(
                    color: Colors.deepPurple, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter your name',
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.deepPurple,
                  ),
                ),
                onChanged: (value) {
                  name = value;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                ' Email',
                style: TextStyle(
                    color: Colors.deepPurple, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.deepPurple,
                  ),
                ),
                onChanged: (value) {
                  email = value;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Password',
                style: TextStyle(
                    color: Colors.deepPurple, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Enter your password',
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.deepPurple,
                  ),
                ),
                onChanged: (value) {
                  password = value;
                },
              ),
              const SizedBox(
                height: 40,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (form.currentState!.validate()) {
                      UserModel? registeredUser =
                          await authController.registerWithEmailAndPassword(
                              email!, password!, name!);
                      if (registeredUser != null) {
                        // Registration successfull
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Registration Successful'),
                              content: const Text(
                                  'You have been successfully registered.'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return Login();
                                    }));
                                    // Navigate to the next screen or perform any desired action
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        // Registration failed
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Registration Failed'),
                              content: const Text(
                                  'An error occured during registration.'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    minimumSize: const Size(150, 50),
                  ),
                  child: const Text(
                    'Register',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
