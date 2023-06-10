import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasepaml/model/contact_model.dart';

class ContactController {
  final contactCollection = FirebaseFirestore.instance.collection('contacts');

  final StreamController<List<DocumentSnapshot>> streamController =
      StreamController<List<DocumentSnapshot>>.broadcast();

  Stream<List<DocumentSnapshot>> get stream => streamController.stream;

  Future<void> addContact(ContactModel ctmodel) async {
    final contact = ctmodel.toMap();

    final DocumentReference docRef = await contactCollection.add(contact);

    final String docID = docRef.id;

    final ContactModel contactModel = ContactModel(
      id: docID,
      name: ctmodel.name,
      email: ctmodel.email,
      phone: ctmodel.phone,
      address: ctmodel.address,
    );

    await docRef.update(contactModel.toMap());
  }

  // Future<void> updateContact(ContactModel ctmodel) async {
  //   var document = contactCollection.doc(ctmodel.id);

  //   final ContactModel contactModel = ContactModel(
  //       id: ctmodel.id,
  //       name: ctmodel.name,
  //       phone: ctmodel.phone,
  //       email: ctmodel.email,
  //       address: ctmodel.address);

  //   await document.update(contactModel.toMap());
  // }

  Future<void> updateContact(ContactModel ctmodel) async {
    final ContactModel contactModel = ContactModel(
        name: ctmodel.name,
        phone: ctmodel.phone,
        email: ctmodel.email,
        address: ctmodel.address,
        id: ctmodel.id);

    await contactCollection.doc(ctmodel.id).update(contactModel.toMap());

    // final DocumentSnapshot documentSnapshot =
    //     await contactCollection.doc(ctmodel.id).get();
    // if (!documentSnapshot.exists) {
    //   return;
    // }

    // final updateContact = contactModel.toMap();
    // await contactCollection.doc(contactModel.id).update(updateContact);
    // await getContact();
  }

  Future<void> removeContact(String id) async {
    await contactCollection.doc(id).delete();
  }

  Future getContact() async {
    final contact = await contactCollection.get();
    streamController.sink.add(contact.docs);
    return contact.docs;
  }
}
