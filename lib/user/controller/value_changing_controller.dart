import 'package:flutter/foundation.dart';

import '../model/bool_model.dart';

class UserBasicController extends ChangeNotifier {
  int _current = 0;
  int get current => _current;
  num _rate =0;
  num get rate =>_rate;

  void updateCurrent(int index) {
    _current = index;
    notifyListeners();
  }
  void updateRate(num rate){
    _rate =rate;
    notifyListeners();
  }
  final  BoolModel _userModel = BoolModel();
  bool get isBool => _userModel.isBool;


  void setLoggedIn(bool value) {
    _userModel.isBool = value;
    notifyListeners();
  }

}

