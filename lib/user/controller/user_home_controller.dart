import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/user_home_model.dart';

class EventController extends ChangeNotifier {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  List<Event> _events = [];

  List<Event> get events => _events;

  Future<void> fetchEvents() async {
    try {
      final snapshot = await _fireStore.collection("Event").get();
      _events = snapshot.docs.map((doc) {
        return Event(
          price:doc.data()["price"].toString(),
          title: doc.data()["Title"],
          description: doc.data()["Description"],
          imageUrl: doc.data()["URLlist"],
        );
      }).toList();
      notifyListeners();
    }on FirebaseException catch (error) {
      print("Error fetching events: $error");
    }
  }
}