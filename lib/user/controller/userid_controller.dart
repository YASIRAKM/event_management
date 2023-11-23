import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserIdController extends ChangeNotifier{
  String id ="";



  Future<String?> getSharedValue(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString("userid")!;
    return prefs.getString(key);
  }
}