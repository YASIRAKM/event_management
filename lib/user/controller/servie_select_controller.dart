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

  Future<void> fetchEventData(uid) async {
    try {
      var snapshot =
          await FirebaseFirestore.instance.collection("Event").doc(uid).get();
      if (snapshot.exists) {
        mapData = snapshot.data();
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  // Future<void> fetchserviceData() async {
  //   try {
  //     var snapshot =
  //         await FirebaseFirestore.instance.collection("Services").get();
  //     if (snapshot.docs.isNotEmpty) {
  //       chkbxl1 = snapshot.docs
  //           .map((doc) => serviceModel(
  //               uid: doc.id,
  //               title: doc["Service"],
  //               imageUrl: doc["URL"],
  //               price: doc["Price"]))
  //           .toList();
  //
  //       notifyListeners();
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

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
