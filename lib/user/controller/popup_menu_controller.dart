import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/popup_menu_model.dart';
import 'package:flutter/foundation.dart';

class PopUpMenuController extends ChangeNotifier {
 final List<StateModel> _states = [
    StateModel('Andaman and Nicobar Islands'),
    StateModel('Andhra Pradesh'),
    StateModel('Arunachal Pradesh'),
    StateModel('Assam'),
    StateModel('Bihar'),
    StateModel('Chandigarh'),
    StateModel('Chhattisgarh'),
    StateModel('Dadra and Nagar Haveli and Daman and Diu'),
    StateModel('Delhi'),
    StateModel('Goa'),
    StateModel('Gujarat'),
    StateModel('Haryana'),
    StateModel('Himachal Pradesh'),
    StateModel('Jammu and Kashmir'),
    StateModel('Jharkhand'),
    StateModel('Karnataka'),
    StateModel('Kerala'),
    StateModel('Ladakh'),
    StateModel('Lakshadweep'),
    StateModel('Madhya Pradesh'),
    StateModel('Maharashtra'),
    StateModel('Manipur'),
    StateModel('Meghalaya'),
    StateModel('Mizoram'),
    StateModel('Nagaland'),
    StateModel('Odisha'),
    StateModel('Puducherry'),
    StateModel('Punjab'),
    StateModel('Rajasthan'),
    StateModel('Sikkim'),
    StateModel('Tamil Nadu'),
    StateModel('Telangana'),
    StateModel('Tripura'),
    StateModel('Uttar Pradesh'),
    StateModel('Uttarakhand'),
    StateModel('West Bengal'),
  ];


  List<StateModel> get states => _states;

  void addState(StateModel state) {
    _states.add(state);
    notifyListeners();
  }
}
class SelectedState extends ChangeNotifier{
    StateModel? _selectedState;

  StateModel? get selectedState => _selectedState;


  void selectState(StateModel state) {
    _selectedState = state;
    notifyListeners();
  }
}
