import 'package:ecommerce_project/app/features/auth/Data/Models/verify_otp_params.dart';
import 'package:ecommerce_project/app/features/auth/presentation/providers/otp_provider.dart';
import 'package:ecommerce_project/app/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:ecommerce_project/app/features/common/presentation/widgets/center_circular_inprogress.dart';
import 'package:ecommerce_project/app/features/home/presentation/home_screen.dart';
import 'package:ecommerce_project/app/features/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.email});
  static const String name = '/otpscreen';

  final String email;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final VerifyOtpProvider _verifyOtpProvider = VerifyOtpProvider();
  final TextEditingController _otpTextController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    return ChangeNotifierProvider(
      create: (_)=> _verifyOtpProvider,
      child: Scaffold(
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
                children: [
          Applogo(),
          Text('Enter Your Otp',style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          Text('4 digit otp is send to your email',style: textTheme.bodyMedium,),
          SizedBox(height: 15,),
          PinCodeTextField(
          appContext: context,
          keyboardType: TextInputType.number,
          length: 4,
                obscureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
          shape:PinCodeFieldShape.box,
          fieldHeight: 50,
          fieldWidth: 40,
          borderRadius: BorderRadius.circular(5),
                ),

                animationDuration: Duration(milliseconds: 300),
                backgroundColor: Colors.transparent,
          controller: _otpTextController,
          ),

          Consumer<VerifyOtpProvider>(
            builder: (context,verifyOtpProvider,_) {
              return Visibility(
                  visible: verifyOtpProvider.verifyOtpInProgress == false,
                  replacement: CenterCircularProgress(),
                  child: FilledButton(onPressed: _TapOnVerifyOtpButton, child: Text('Next')));
            }
          )
                ],
          ),
        ),
      )),
      ),
    );
  }

  void _TapOnVerifyOtpButton() {
    if (_formKey.currentState!.validate()) {
      _verifyOtp();
    }
  }


  Future<void> _verifyOtp()async{
    final bool isSuccess = await _verifyOtpProvider.verifyOtp(
        VerifyOtpParams(otp: _otpTextController.text.trim(),
          email: widget.email,//karon amra email ager screen theke niye ashbo

    )
    );

    if(isSuccess){
      Navigator.pushNamed(context, SignInScreen.name);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_verifyOtpProvider.errorMassege!)));
    }
  }
}

