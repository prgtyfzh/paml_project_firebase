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
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              TextFormField(
                onChanged: (value) {
                  newname = value;
                },
                initialValue: widget.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama harus diisi!';
                  }
                  return null;
                },
              ),
              TextFormField(
                onChanged: (value) {
                  newphone = value;
                },
                initialValue: widget.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Phone harus diisi!';
                  }
                  return null;
                },
              ),
              TextFormField(
                onChanged: (value) {
                  newemail = value;
                },
                initialValue: widget.email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email harus diisi!';
                  }
                  return null;
                },
              ),
              TextFormField(
                onChanged: (value) {
                  newaddress = value;
                },
                initialValue: widget.address,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Address harus diisi!';
                  }
                  return null;
                },
              ),
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
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
