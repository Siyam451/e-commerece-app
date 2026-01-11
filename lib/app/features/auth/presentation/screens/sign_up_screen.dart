import 'package:ecommerce_project/app/app_color.dart';
import 'package:ecommerce_project/app/features/auth/Data/Models/sign_up-params.dart';
import 'package:ecommerce_project/app/features/auth/presentation/providers/signup_provider.dart';
import 'package:ecommerce_project/app/features/auth/presentation/screens/otp-screen.dart';
import 'package:ecommerce_project/app/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:ecommerce_project/app/features/common/presentation/widgets/center_circular_inprogress.dart';
import 'package:ecommerce_project/app/features/widgets/app_logo.dart';
import 'package:ecommerce_project/l10n/app_localizations.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const String name = '/sign-up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignupProvider _signUpProvider = SignupProvider();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _phoneTEController = TextEditingController();
  final TextEditingController _cityTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    return ChangeNotifierProvider(
      create: (_) => _signUpProvider,// aikane create korchi karon amra chai na ai provider ta onno screen e o effect felok
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
                        controller: _firstNameTEController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: 'First Name',

                        ),
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? true) {
                            return 'Enter your First Name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _lastNameTEController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: 'Last Name',

                        ),
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? true) {
                            return 'Enter your Last Name';
                          }
                          return null;
                        },
                      ),
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
                      TextFormField(
                        controller: _phoneTEController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,

                        decoration: InputDecoration(
                          hintText: 'Mobile',

                        ),
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? true) {
                            return 'Enter your Mobile number';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _cityTEController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: 'City',
                        ),
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? true) {
                            return 'Enter your city';
                          }
                          return null;
                        },
                      ),


                      Consumer<SignupProvider>(
                        builder: (context,signupprovider,child) {
                          return Visibility(
                            visible: signupprovider.signUpInProgress == false,
                            replacement: CenterCircularProgress(),
                            child: FilledButton(
                                onPressed: _TapOnSignUpButton, child: Text(AppLocalizations.of(context)!.signupbutton)),
                          );
                        }
                      ),

                      RichText(text: TextSpan(
                        style: textTheme.bodyMedium,
                        text: 'Already Have an Account?',

                        children: [
                          TextSpan(
                            style: TextStyle(
                              color: AppColors.themeColor,
                              fontWeight: FontWeight.bold,
                            ),
                            text: 'Sign In',
                            recognizer: TapGestureRecognizer()..onTap = _TapOnSignInButton
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

  void _TapOnSignInButton(){
    Navigator.pushNamed(context, SignInScreen.name);
  }

  void _TapOnSignUpButton() {
    if (_formKey.currentState!.validate()) {
      _signup();
    }
  }



  Future<void> _signup()async{
    final bool isSuccess = await _signUpProvider.signUp(
        SignUpParams(
            firstName: _firstNameTEController.text.trim(),
            lastName: _lastNameTEController.text.trim(),
            email: _emailTEController.text.trim(),
            password: _passwordTEController.text.trim(),
            phone: _phoneTEController.text.trim(),
            city: _cityTEController.text,)
    );

    if(isSuccess){
      Navigator.pushNamed(context, OtpScreen.name,arguments: _emailTEController.text.trim());
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_signUpProvider.errorMassege!)));
    }
  }

  @override
  void dispose() {
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _emailTEController.dispose();
    _passwordTEController.dispose();
    _phoneTEController.dispose();
    _cityTEController.dispose();
    super.dispose();
  }
}
