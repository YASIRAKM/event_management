
import 'package:flutter/material.dart';

import '../model/bool_model.dart';

class BooController extends ChangeNotifier {
 final  BoolModel _userModel = BoolModel();
  bool get isBool => _userModel.isBool;


  void setLoggedIn(bool value) {
    _userModel.isBool = value;
    notifyListeners();
  }


}