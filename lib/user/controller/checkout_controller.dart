
import 'dart:developer';

import 'package:flutter/material.dart';

import '../model/checkout_model.dart';

class CheckOutController extends ChangeNotifier {
  final CheckOutModel _model = CheckOutModel();

  num get total => _model.total;

  void updateTotal(Map<String, dynamic> events, List<dynamic> listOfMaps) {
    try{
    _model.calculateTotal(events, listOfMaps);
    notifyListeners();}
        catch(e){
      print(e);
        }
  }
}