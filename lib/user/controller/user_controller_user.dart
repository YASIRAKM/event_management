
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> registerUser({
    required String name,
    required String email,
    required String phone,
    required String district,
    required String state,
    required String password,

  }) async {
    try {
      final authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

 User? user = authResult.user;


      if (user != null) {

        await _firestore.collection("Users").add({
          "Id": user.uid,
          "Name": name,
          "E mail": email,
          "Phone no": phone,
          "District": district,
          "State": state,
          "Password": password,
        });


        notifyListeners();
      }
    } on FirebaseAuthException catch(e) {
log(e.toString(),);
      print(e);
    }
  }
}
