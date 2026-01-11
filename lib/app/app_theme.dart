import 'package:ecommerce_project/app/app_color.dart';
import 'package:flutter/material.dart';
//controll theme of the app
class Apptheme {
  static ThemeData get LightTheme{
    return ThemeData(
      brightness: Brightness.light,
      colorSchemeSeed: AppColors.themeColor,
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.themeColor,
      ),
      inputDecorationTheme:_getInputDecorationTheme(),
        filledButtonTheme:_getFilledButtonTheme()

    );

  }
  static ThemeData get DarkTheme{
    return ThemeData(
        brightness: Brightness.dark,
      colorSchemeSeed: AppColors.themeColor,
      inputDecorationTheme:_getInputDecorationTheme(),
      filledButtonTheme:_getFilledButtonTheme()

    );
  }

  static InputDecorationTheme _getInputDecorationTheme(){
    return InputDecorationTheme(
      hintStyle: TextStyle(
        fontWeight: FontWeight.w300,
      ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.themeColor),
        ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.themeColor)
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.themeColor)
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red)
      ),
    );
  }

  static FilledButtonThemeData _getFilledButtonTheme(){
    return FilledButtonThemeData(
      style: FilledButton.styleFrom(
          fixedSize: Size.fromWidth(double.maxFinite),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: AppColors.themeColor,
          textStyle: TextStyle(
              fontWeight: FontWeight.w700
          )
      ),
    );
  }
}