import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier{

  ThemeMode appTheme = ThemeMode.light;



  void changeTheme(ThemeMode newMode) {
    if (appTheme == newMode) {
      return;
    }
    appTheme = newMode;
    saveTheme();
  }


  saveTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('theme', appTheme.index);
    prefs.reload();
    notifyListeners();
  }
  loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? themeIndex = prefs.getInt('theme');
    if (themeIndex != null) {
      appTheme = ThemeMode.values[themeIndex];
    }
    notifyListeners();
  }



  bool isDarkMode() {
    return appTheme == ThemeMode.dark;
  }
}