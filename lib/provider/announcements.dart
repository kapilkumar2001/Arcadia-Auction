import 'package:arcadia/provider/announcement.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Announcements with ChangeNotifier {
  List<Announcement> annoucment = [
   
  ];

  Future<void> addanncoument(Announcement p) async {
    CollectionReference annoucment =
        FirebaseFirestore.instance.collection('Announcement');

    

    await annoucment.doc(p.id).set(p.toMap());
    notifyListeners();
    return;
  }

  Future<void> fetchAndSetAnnouncement() async {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('Announcement');

    QuerySnapshot allDataQuerySnapshot = await _collectionRef.get();

    final announcement = allDataQuerySnapshot.docs
        .map((doc) => doc.data())
        .toList()
        .map((e) => Announcement.fromMap(e as Map<String, dynamic>))
        .toList();
  }
}
