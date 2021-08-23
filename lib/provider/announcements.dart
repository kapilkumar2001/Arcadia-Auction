import 'package:arcadia/provider/announcement.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Announcements with ChangeNotifier {
  List<Announcement> announcement = [];

  Future<void> addAnncoument(Announcement p) async {
    CollectionReference annoucement =
        FirebaseFirestore.instance.collection('Announcement');

    await annoucement.doc(p.id).set(p.toMap());
    notifyListeners();
    return;
  }

  Future<void> fetchAndSetAnnouncement() async {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('Announcement');

    QuerySnapshot allDataQuerySnapshot = await _collectionRef.get();

    announcement = allDataQuerySnapshot.docs
        .map((doc) => doc.data())
        .toList()
        .map((e) => Announcement.fromMap(e as Map<String, dynamic>))
        .toList();
  }
}
