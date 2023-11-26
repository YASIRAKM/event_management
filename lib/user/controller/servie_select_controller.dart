import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



class ServiceSelectController with ChangeNotifier {
  TextEditingController dateController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  List chkBox1 = [];
  Map<String, dynamic>? mapData;
  var chkBox2 = [];
  DateFormat dtFormat = DateFormat('dd-MM-yyyy');

  // Future<void> fetchEventData(uid) async {
  //   try {
  //     var snapshot =
  //         await FirebaseFirestore.instance.collection("Event").doc(uid).get();
  //     if (snapshot.exists) {
  //       mapData = snapshot.data();
  //       notifyListeners();
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  late num total ;

  void calculateTotal(
      Map<String, dynamic> events
      , List<dynamic> listOfMaps) {
    try{
      num totalSum =num.parse(events["price"]);
      for (var map in listOfMaps) {
        totalSum += map["Price"];
      }
      total = totalSum;}
    catch(e){
      print(e);

    }
    notifyListeners();
  }



  void toggleSelect(l2) async {
    if (chkBox2.contains(l2)) {
      chkBox2.remove(l2);
    } else {
      chkBox2.add(l2);
    }
    notifyListeners();
  }
  void deleteButton(l3)async{
    chkBox2.remove(l3);
    notifyListeners();
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      dateController.text = dtFormat.format(selectedDate);
      notifyListeners();
    }
  }
}
