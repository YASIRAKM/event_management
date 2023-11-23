import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EventModel {
  String id;
  String title;
  String description;
  double price;
  List<String> imageURLs;

  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageURLs,
  });
  factory EventModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    List<dynamic>? documentImageUrls = snapshot['URLlist'];
    List<String> imageUrls = [];
    if (documentImageUrls != null && documentImageUrls.isNotEmpty) {
      imageUrls.add(documentImageUrls[0]);
    }
    return EventModel(
      id: snapshot.id,
      title: snapshot.data()!['title'],
      description: snapshot.data()!['description'],
      price: snapshot.data()!['price'],
      imageURLs: imageUrls,
    );
  }

  }




class EventAdminController extends ChangeNotifier {
  List<EventModel> events = [];

  Future<void> fetchEvents() async {
    try {
      var snapshot = await FirebaseFirestore.instance.collection("Event").get();
      events = snapshot.docs.map((doc) {
        return EventModel.fromSnapshot(doc);
      }).toList();

      // events = snapshot.docs.map((doc) {
      //   List<dynamic>? imageURLs = doc['URLlist'];
      //   return EventModel(
      //     id: doc.id,
      //     title: doc['Title'],
      //     description: doc['Description'],
      //     price: doc['price'],
      //     imageURLs: imageURLs != null ? List<String>.from(imageURLs) : [],
      //   );
      // }).toList();

      notifyListeners();
    } catch (error) {
      print("Error fetching events: $error");
    }
  }

  Future<void> deleteEvent(String eventId) async {
    try {
      await FirebaseFirestore.instance.collection("Event").doc(eventId).delete();
      await fetchEvents();
    } catch (error) {
      print("Error deleting event: $error");
    }
  }
}








