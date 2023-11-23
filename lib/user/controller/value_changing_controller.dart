import 'package:flutter/foundation.dart';

class ValueChanger extends ChangeNotifier {
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
}

