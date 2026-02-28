import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ostad_tm/ui/screens/sign_up_screen.dart';
import 'package:ostad_tm/ui/widgets/screen_background.dart';

import 'forgot_password_email_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  static const String name = '/ChangePasswordScreen';

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController = TextEditingController();
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
                  Text("Change Password",style: Theme.of(context).textTheme.titleLarge,),
                  SizedBox(height: 10,),
                  Text("Password should be more then 6 letters",style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.grey),),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: _passwordTEController,
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      hintText: "Password",
                    ),
                    validator: (String? value){
                      if((value?.length ?? 0) <=5 ){
                        return "Enter valid Password";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: _confirmPasswordTEController,
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      hintText: "Confirm Password",
                    ),
                    validator: (String? value){
                      if((value ?? "") != _passwordTEController.text.trim() ){
                        return "Confirm Password does not match";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10,),
                  ElevatedButton(
                    onPressed: _onTapLogInButton,
                    child: Icon(Icons.arrow_circle_right_outlined, size: 20,),
                  ),
                  SizedBox(height: 32,),
                  TextButton(onPressed: _onTapForgotButton, child: Text('Forgot Password',style: TextStyle(color: Colors.grey),)),
                  SizedBox(height: 10,),
                  RichText(text: TextSpan(
                    text: "Don't have any account? ",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      letterSpacing: .4
                    ),
                    children: [
                      TextSpan(
                        text: "Sign Up",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w700
                        ),
                        recognizer: TapGestureRecognizer()..onTap = _onTapSignUpButton
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

  void _onTapSignUpButton(){
       Navigator.pushNamed(context, SignUpScreen.name);
  }

  void _onTapForgotButton(){
    Navigator.pushNamed(context, ForgotPasswordEmailScreen.name);
  }

  void _onTapLogInButton(){
    if(_forKey.currentState!.validate()){
      // to do sign in
    }
  }

  @override
  void dispose() {
   _confirmPasswordTEController.dispose();
   _passwordTEController.dispose();
    super.dispose();
  }
}
