import 'package:ecommerce_project/app/app_color.dart';
import 'package:ecommerce_project/app/features/auth/Data/Models/sign_in_params.dart';
import 'package:ecommerce_project/app/features/auth/presentation/providers/signin_provider.dart';
import 'package:ecommerce_project/app/features/auth/presentation/providers/signup_provider.dart';
import 'package:ecommerce_project/app/features/auth/presentation/screens/otp-screen.dart';
import 'package:ecommerce_project/app/features/common/presentation/widgets/showsnacbar_masaage.dart';
import 'package:ecommerce_project/app/features/widgets/app_logo.dart';
import 'package:ecommerce_project/l10n/app_localizations.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/presentation/widgets/center_circular_inprogress.dart';
import '../../../common/screens/bottom_navbar.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  static const String name = '/sign-In';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final SigninProvider _signinProvider = SigninProvider();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    return ChangeNotifierProvider(
      create: (_) => _signinProvider,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  spacing: 8,
                  children: [

                    Applogo(),

                    Text(AppLocalizations.of(context)!.completeProfile,style:
                    textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),),

                    Text(AppLocalizations.of(context)!.profilemassage,style: textTheme.bodySmall,),

                    TextFormField(
                      controller: _emailTEController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Email',
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your Email';
                        }
                        return null;
                      },
                    ),

                    TextFormField(
                      controller: _passwordTEController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Password',
                      ),
                      validator: (String? value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Enter your password';
                        }

                        if (value.trim().length < 6) {
                          return 'Password must be at least 6 characters';
                        }

                        return null;
                      },

                    ),

                    Consumer<SigninProvider>(
                      builder: (context,signInprovider,_) {

                        return Visibility(
                          visible: signInprovider.IsSignInProgress == false,
                          replacement: CenterCircularProgress(),
                          child: FilledButton(
                              onPressed: _TapOnSignInButton, child: Text(AppLocalizations.of(context)!.gotoemailscreen)),
                        );
                      }
                    ),

                    RichText(text: TextSpan(
                        style: textTheme.bodyMedium,
                        text: 'Do you Have an Account?',

                        children: [
                          TextSpan(
                              style: TextStyle(
                                color: AppColors.themeColor,
                                fontWeight: FontWeight.bold,
                              ),
                              text: 'Sign up',
                              recognizer: TapGestureRecognizer()..onTap = _TapOnSignUpButton,
                          ),

                        ]
                    ))





                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  void _TapOnSignUpButton(){
    Navigator.pop(context);
  }

  void _TapOnSignInButton(){
    if(_formKey.currentState!.validate()){
      _SignIn();
    }
  }

  Future <void> _SignIn()async{
     SignInParams params = SignInParams(
         password: _passwordTEController.text,
         email: _emailTEController.text.trim());

     final bool isSucess = await _signinProvider.SignIn(params);

     if(isSucess){
       Navigator.pushNamedAndRemoveUntil(context, BottomNavbar.name, (predicate)=>false);
     }else{
       ShowSnacbarMassage(context, _signinProvider.errorMassege!);

     }
  }

}

