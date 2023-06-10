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
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                onChanged: (value) {
                  name = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                onChanged: (value) {
                  email = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                onChanged: (value) {
                  password = value;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (form.currentState!.validate()) {
                    UserModel? registeredUser = await authController
                        .registerWithEmailAndPassword(email!, password!, name!);
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
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
