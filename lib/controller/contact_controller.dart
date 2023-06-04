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

  Future<void> removeContact(String id) async {
    await contactCollection.doc(id).delete();
  }

  Future getContact() async {
    final contact = await contactCollection.get();
    streamController.sink.add(contact.docs);
    return contact.docs;
  }
}
