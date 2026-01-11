import 'package:flutter/cupertino.dart';

class BottomNavbarProvider extends ChangeNotifier{
 int _selectedIndex = 0;

 int get selectedIndex => _selectedIndex;

 void changeItem (int index){
   if(_selectedIndex == index) return; //jdi same jinish select kore kichu hbe na

   _selectedIndex = index; // ar na hoi change hbe
   notifyListeners();
 }

 void ChangeToCategories(){
   changeItem(1); // 1 number index e jabe

 }
 void ChangeToPopularItem(){
   changeItem(1); // 1 number index e jabe

 }

 void BacktoHome(){
   changeItem(0); // 1 number index e jabe

 }
}