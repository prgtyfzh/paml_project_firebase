import 'package:firebasepaml/controller/contact_controller.dart';
import 'package:firebasepaml/model/contact_model.dart';
import 'package:firebasepaml/view/contact.dart';
import 'package:flutter/material.dart';

class UpdateContact extends StatefulWidget {
  const UpdateContact({
    Key? key,
    this.id,
    this.name,
    this.phone,
    this.email,
    this.address,
  }) : super(key: key);

  final String? id;
  final String? name;
  final String? phone;
  final String? email;
  final String? address;

  @override
  State<UpdateContact> createState() => _UpdateContactState();
}

class _UpdateContactState extends State<UpdateContact> {
  var contactController = ContactController();

  final formkey = GlobalKey<FormState>();

  String? newname;
  String? newphone;
  String? newemail;
  String? newaddress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.deepPurple,
                  ),
                ),
                onSaved: (value) {
                  newname = value;
                },
                initialValue: widget.name,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.phone,
                    color: Colors.deepPurple,
                  ),
                ),
                onSaved: (value) {
                  newphone = value;
                },
                initialValue: widget.phone,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.deepPurple,
                  ),
                ),
                onSaved: (value) {
                  newemail = value;
                },
                initialValue: widget.email,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.room,
                    color: Colors.deepPurple,
                  ),
                ),
                onSaved: (value) {
                  newaddress = value;
                },
                initialValue: widget.address,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    formkey.currentState!.save();
                    ContactModel cm = ContactModel(
                      id: widget.id,
                      name: newname!.toString(),
                      phone: newphone!.toString(),
                      email: newemail!.toString(),
                      address: newaddress!.toString(),
                    );
                    contactController.updateContact(cm);
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Contact Changed')));
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
