import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ModelApp with ChangeNotifier {
  bool isLoading = true;
  bool appInBackground = true;
  String message;
  bool darkTheme = false;
  String username;
  String locale = 'ar';
  bool isInit = false;
  TextDirection textDecoration = TextDirection.rtl;
  ModelApp();
  Future<bool> changeLanguage(String country, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      locale = country;
      textDecoration = locale == 'ar' ? TextDirection.rtl : TextDirection.ltr;
      await prefs.setString("language", country);
      notifyListeners();
      return true;
    } catch (err) {
      return false;
    }
  }

}
