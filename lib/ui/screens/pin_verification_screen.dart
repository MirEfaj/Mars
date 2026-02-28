import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ostad_tm/ui/screens/sign_in_screen.dart';
import 'package:ostad_tm/ui/widgets/screen_background.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'change_password_screen.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key});

  static const String name = '/PinVerificationScreen';

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
    final PinInputController _otpTEController = PinInputController();
  final GlobalKey<FormState> _forKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _forKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  SizedBox(height: 80,),
                  Text("Pin Verification",style: Theme.of(context).textTheme.titleLarge,),
                  SizedBox(height: 10,),
                  Text("A 6 digit OTP has been send to your email address",style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.grey),),
                  SizedBox(height: 20,),
                  MaterialPinField(
                    length: 6,
                    pinController: _otpTEController,
                    onCompleted: (pin) {
                      debugPrint('PIN: $pin');
                    },
                    onChanged: (value) {
                      debugPrint('Changed: $value');
                    },
                    theme: MaterialPinTheme(
                      fillColor: Colors.transparent,
                      focusedFillColor: Colors.transparent,
                      completeFillColor: Colors.transparent,
                      shape: MaterialPinShape.outlined,
                      cellSize: const Size(45, 50),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  SizedBox(height: 10,),
                  ElevatedButton(
                    onPressed: _onTapSubmitButton,
                    child: Icon(Icons.arrow_circle_right_outlined, size: 20,),
                  ),
                  SizedBox(height: 32,),
                  RichText(text: TextSpan(
                    text: "Have any account? ",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      letterSpacing: .4
                    ),
                    children: [
                      TextSpan(
                        text: "Sign In",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w700
                        ),
                        recognizer: TapGestureRecognizer()..onTap = _onTapSignInButton
                      ),
                    ]
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSignInButton(){
       Navigator.pushNamedAndRemoveUntil(context, SignInScreen.name, (predicate)=> false);
  }


  // void _onTapSubmitButton(){
  //   if(_forKey.currentState!.validate()){
  //     Navigator.pushNamed(context, HomePage.name);
  //   }
  // }

    void _onTapSubmitButton() {
      final otp = _otpTEController.text;

      if (!_isValidOtp(otp)) return;

      _goToHome();
    }

    bool _isValidOtp(String otp) {
      if (otp.isEmpty) {
        _showError("Please enter OTP");
        return false;
      }

      if (otp.length != 6) {
        _showError("OTP must be 6 digits");
        return false;
      }

      return true;
    }

    void _goToHome() {
    Navigator.pushReplacementNamed(context, ChangePasswordScreen.name,);
    }

    void _showError(String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  @override
  void dispose() {
   _otpTEController.dispose();
    super.dispose();
  }
}
