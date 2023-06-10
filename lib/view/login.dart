import 'package:firebasepaml/model/user_model.dart';
import 'package:firebasepaml/view/register.dart';
import 'package:flutter/material.dart';

import '../controller/auth_controller.dart';
import 'contact.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final form = GlobalKey<FormState>();
  final authController = AuthController();

  @override
  Widget build(BuildContext context) {
    String? email;
    String? password;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
            key: form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          if (form.currentState!.validate()) {
                            UserModel? registeredUser = await authController
                                .signInWithEmailAndPassword(email!, password!);
                            if (registeredUser != null) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Login Successful'),
                                    content: const Text(
                                        'You have been successfully login.'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: ((context) {
                                            return Contact();
                                          })));
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Login Failed'),
                                      content: const Text(
                                          'An error occurred during registration.'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('OK'),
                                        )
                                      ],
                                    );
                                  });
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
                          'Login',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?"),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Register(),
                                ),
                              );
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
