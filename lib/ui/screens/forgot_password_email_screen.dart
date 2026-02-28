import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ostad_tm/ui/screens/pin_verification_screen.dart';
import 'package:ostad_tm/ui/screens/sign_in_screen.dart';
import 'package:ostad_tm/ui/screens/sign_up_screen.dart';
import 'package:ostad_tm/ui/widgets/screen_background.dart';

class ForgotPasswordEmailScreen extends StatefulWidget {
  const ForgotPasswordEmailScreen({super.key});

  static const String name = '/ForgotPasswordEmailScreen';

  @override
  State<ForgotPasswordEmailScreen> createState() => _ForgotPasswordEmailScreenState();
}

class _ForgotPasswordEmailScreenState extends State<ForgotPasswordEmailScreen> {
  final TextEditingController _emailTEController = TextEditingController();
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
                  Text("Your Email Address",style: Theme.of(context).textTheme.titleLarge,),
                  SizedBox(height: 10,),
                  Text("A 6 digit OTP will be sent to your email address",style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.grey),),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: _emailTEController,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Email",
                    ),
                    validator: (String? value){
                      String email = value ?? '';
                      if( EmailValidator.validate(email) == false){
                        return "Enter valid Email";
                      }
                      return null;
                    },
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
       Navigator.pushNamed(context, SignInScreen.name);
  }


  void _onTapSubmitButton(){
    if(_forKey.currentState!.validate()){
      Navigator.pushNamed(context, PinVerificationScreen.name);
    }
    Navigator.pushNamed(context, PinVerificationScreen.name);
  }

  @override
  void dispose() {
   _emailTEController.dispose();
    super.dispose();
  }
}
