
import 'package:flutter/material.dart';

void ShowSnacbarMassage(BuildContext context,String massage){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(massage)));
}
