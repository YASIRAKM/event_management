import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddUpdate extends ChangeNotifier{
  Future addData(String collection,Map<String,dynamic> addData)async{
   final  ref = await FirebaseFirestore.instance;
   await ref.collection(collection).add(addData);
    notifyListeners();
  }
  Future updateData(collection, docId ,Map<String,dynamic> upData)async{
    final  ref = await FirebaseFirestore.instance;
    await ref.collection(collection).doc(docId).update(upData);
    notifyListeners();
  }
  Future deleteData(collection, docId )async{
    final  ref = await FirebaseFirestore.instance;
    await ref.collection(collection).doc(docId).delete();
  }
}