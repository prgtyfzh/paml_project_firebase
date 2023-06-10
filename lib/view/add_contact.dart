import 'package:firebasepaml/controller/contact_controller.dart';
import 'package:firebasepaml/model/contact_model.dart';
import 'package:firebasepaml/view/contact.dart';
import 'package:flutter/material.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  var contactController = ContactController();

  final formkey = GlobalKey<FormState>();

  String? name;
  String? phone;
  String? email;
  String? address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Name',
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.deepPurple,
                  ),
                ),
                onChanged: (value) {
                  name = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Phone',
                  prefixIcon: Icon(
                    Icons.phone,
                    color: Colors.deepPurple,
                  ),
                ),
                onChanged: (value) {
                  phone = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Email',
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.deepPurple,
                  ),
                ),
                onChanged: (value) {
                  email = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Address',
                  prefixIcon: Icon(
                    Icons.room,
                    color: Colors.deepPurple,
                  ),
                ),
                onChanged: (value) {
                  address = value;
                },
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    ContactModel cm = ContactModel(
                      name: name!,
                      phone: phone!,
                      email: email!,
                      address: address!,
                    );
                    contactController.addContact(cm);
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Contact Added')));
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Contact(),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: const Size(100, 50),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
