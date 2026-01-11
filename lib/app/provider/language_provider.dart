import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier{
  Locale _currentLocale = Locale('en') ;// current e set kora ase aita

  Locale get currentLocale => _currentLocale; // get korsi karon private jinish aita normal e access kora jabe na
  //app restart dile o jate jeita change korse oita thaki jai tai
  Future<void> loadinitialLanguage()async{
    Locale locale = await _getLocale();
    _currentLocale = locale;
    notifyListeners();
  }
void changeLocale(Locale newLocale){
  if(_currentLocale == newLocale) return;
  // ar na hoi nicher ta korba
  _currentLocale = newLocale;
  _saveLocale(_currentLocale.languageCode);
  notifyListeners();
}


Future<void> _saveLocale(String Locale)async{
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.setString('Locale', Locale);
}

  Future<Locale> _getLocale()async{
    //sharedprefer.. diye data save rakhe...jate restart dile o ja change korsi ta thake
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String savedLocale =  sharedPreferences.getString('Locale') ?? 'en'; // jdi amra di taile change hbe ar na hoi default e english set korlam
    return Locale(savedLocale);
  }



}