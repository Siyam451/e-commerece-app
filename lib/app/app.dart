import 'package:ecommerce_project/app/app-routes.dart';
import 'package:ecommerce_project/app/app_theme.dart';
import 'package:ecommerce_project/app/features/auth/presentation/screens/splash_screen.dart';
import 'package:ecommerce_project/app/features/cartList/providers/cart_list_provider.dart';
import 'package:ecommerce_project/app/features/categories/provider/category_list_provider.dart';
import 'package:ecommerce_project/app/features/common/provider/bottom_navbar_provider.dart';
import 'package:ecommerce_project/app/features/home/providers/home_slider_provider.dart';
import 'package:ecommerce_project/app/features/product/providers/product_list_by_category_provider.dart';
import 'package:ecommerce_project/app/provider/auth_provider.dart';
import 'package:ecommerce_project/app/provider/language_provider.dart';
import 'package:ecommerce_project/app/provider/thememode_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';

class CraftyApp extends StatefulWidget {
  const CraftyApp({super.key});
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<CraftyApp> createState() => _CraftyAppState();
}

class _CraftyAppState extends State<CraftyApp> {
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> LanguageProvider()..loadinitialLanguage()),//.. diye mainly provider call er somoy language save er ta o save korte bujhano hoiche
        ChangeNotifierProvider(create: (_)=> ThememodeProvider() ..loadinitialThemeMode(),),
        ChangeNotifierProvider(create: (_)=> BottomNavbarProvider()),
        ChangeNotifierProvider(create: (_)=> CategoryListProvider()),
        ChangeNotifierProvider(create: (_)=> HomeSliderProvider()),
        ChangeNotifierProvider(create: (_)=> AuthProvider()),
        ChangeNotifierProvider(create: (_)=> CartListProvider())
      ],
      child: Consumer<LanguageProvider>(
        builder: (context,languageProvider,child) {
          return Consumer<ThememodeProvider>(
            builder: (context,thememodeprovider,child) {
              return MaterialApp(
                navigatorKey: CraftyApp.navigatorKey,
                initialRoute: SplashScreen.name,
                onGenerateRoute: AppRoutes.route,//route thik kore dewa j ki kon page theke kon kane jabe
                theme: Apptheme.LightTheme,
                darkTheme: Apptheme.DarkTheme,
                themeMode:  thememodeprovider.currentThememode, //current theme mode kinhbe ta set
                localizationsDelegates: [
                  AppLocalizations.delegate,// ait must dite hbe
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                // kon kon language takbe er list
                supportedLocales: [
                  Locale('en'), // English
                  Locale('bn'), //bangla
                  Locale('de')// germen
                ],
                locale: languageProvider.currentLocale //kon language defalut e rakha
              );
            }
          );
        }
      ),
    );
  }
}
