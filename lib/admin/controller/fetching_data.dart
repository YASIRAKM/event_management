// import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FetchDataAdmin extends ChangeNotifier {
  final StreamController<List<Map<String, dynamic>>> _dataController =
      StreamController<List<Map<String, dynamic>>>.broadcast();
  final StreamController<Map<String, dynamic>> _dataController2 =
      StreamController<Map<String, dynamic>>.broadcast();
  Stream<List<Map<String, dynamic>>> get dataStream => _dataController.stream;
  Stream<Map<String, dynamic>> get dataStream2 => _dataController2.stream;
  void fetchDataWithOutDoc(String collectionName) {
    FirebaseFirestore.instance.collection(collectionName).snapshots().listen(
        (snapshot) {
      List<Map<String, dynamic>> data = snapshot.docs
          .map((doc) {
        Map<String, dynamic> docData =doc.data() ;
          docData['id'] = doc.id; // Add document ID to the map
          return docData;
          })
          .toList();
      _dataController.add(data);
    }, onError: (error) {
      // Handle error
      print('Error fetching data: $error');
    });
    notifyListeners();
  }
  void fetchDataWithDocument(String collectionName, String documentId) {
    FirebaseFirestore.instance
        .collection(collectionName)
        .doc(documentId)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        Map<String, dynamic> docData = snapshot.data() as Map<String, dynamic>;
        _dataController2.add(docData);
      } else {
        _dataController.addError('Document not found');
      }
    }, onError: (error) {
      // Handle error
      print('Error fetching data: $error');
      _dataController.addError(error.toString());
    });
    notifyListeners();
  }
  void fetchDataWithCondition(String collectionName,var where) {
    FirebaseFirestore.instance.collection(collectionName).where(where).snapshots().listen(
            (snapshot) {
          List<Map<String, dynamic>> data = snapshot.docs
              .map((doc) {
            Map<String, dynamic> docData =doc.data() ;
            docData['id'] = doc.id; // Add document ID to the map
            return docData;
          })
              .toList();
          _dataController.add(data);
        }, onError: (error) {
      // Handle error
      print('Error fetching data: $error');
    });
    notifyListeners();
  }

  @override
  void dispose() {
    _dataController.close();
    super.dispose();
  }


}
