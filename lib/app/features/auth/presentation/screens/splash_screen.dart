import 'package:ecommerce_project/app/assets_paths.dart';
import 'package:ecommerce_project/app/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:ecommerce_project/app/features/common/presentation/widgets/language_selector.dart';
import 'package:ecommerce_project/app/features/common/screens/bottom_navbar.dart';
import 'package:ecommerce_project/app/provider/thememode_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../../l10n/app_localizations.dart';
import '../../../widgets/app_logo.dart';
import '../providers/auth_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String name = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _movetoNextScreen();
  }

  // Future<void> _movetoNextScreen()async{
  //   await Future.delayed(Duration(seconds: 3));
  // // Navigator.pushNamedAndRemoveUntil(context,BottomNavbar.name , (predicate)=> false);
  //   Navigator.pushNamedAndRemoveUntil(context,BottomNavbar.name , (predicate)=> false);
  // }
  Future<void> _movetoNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));

    final bool isLoggedIn =
    await AuthController.IsUserAlreadyLoggedIn();

    if (!mounted) return;

    if (isLoggedIn) {
      await AuthController.getUserData(); // load token + user
      Navigator.pushNamedAndRemoveUntil(
        context,
        BottomNavbar.name,
            (route) => false,
      );
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        SignUpScreen.name, // or LoginScreen
            (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThememodeProvider>(context);
     return Scaffold(
      //class 1 and 2 lecture
      // body: Center(
      //   child: Column(
      //     children: [
      //        Text(AppLocalizations.of(context)!.hello),
      //       LanguageSelector(),
      //
      //       SizedBox(height: 20,),
      //
      //
      //       IconButton(onPressed: (){
      //
      //         themeProvider.changetheme (
      //             themeProvider.currentThememode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark );
      //       }, icon: Icon(themeProvider.currentThememode == ThemeMode.dark ?
      //       Icons.dark_mode : Icons.light_mode
      //       ))
      //
      //
      //     ],
      //   ),
      //
      // ),



       body: Center(
         child: Column(
           children: [
             Spacer(),
             Applogo(),
             Spacer(),

             CircularProgressIndicator(),
             SizedBox(height: 50,)
           ],
         ),
       ),
    );
  }
}

