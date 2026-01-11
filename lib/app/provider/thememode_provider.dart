import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThememodeProvider extends ChangeNotifier{
  final String? _themekey = 'themeMode';
  ThemeMode _currentThememode = ThemeMode.system;// current e set kora ase aita
  // ThemeMode themeMode = ThemeMode.light;
  // bool get isDarkMode => themeMode == ThemeMode.dark;
  // void toggleTheme(){
  //   themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
  //   notifyListeners();
  // }

  ThemeMode get currentThememode => _currentThememode; // get korsi karon private jinish aita normal e access kora jabe na
  //app restart dile o jate jeita change korse oita thaki jai tai
  Future<void> loadinitialThemeMode()async{
    ThemeMode mode = await _getThemeMode();
    _currentThememode = mode;
    notifyListeners();
  }
  void changetheme(ThemeMode mode){
    if(_currentThememode == mode) return;
    // ar na hoi nicher ta korba
    _currentThememode = mode;
    _saveThememode(mode.name);
    notifyListeners();
  }


  Future<void> _saveThememode(String mode)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_themekey!, mode);
  }

  Future<ThemeMode> _getThemeMode() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String savedThemeMode = sharedPreferences.getString(_themekey!) ?? '';
    return getThemeModeFromString(savedThemeMode);
  }
  ThemeMode getThemeModeFromString(String v) {
    switch (v) {
    case 'light':
    return ThemeMode.light;
    case 'dark':
    return ThemeMode.dark;
    default:
    return ThemeMode.system;
    }

  }



}