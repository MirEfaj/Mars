import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ostad_tm/ui/screens/sign_up_screen.dart';
import 'package:ostad_tm/ui/widgets/screen_background.dart';

import 'forgot_password_email_screen.dart';
import 'main_nav_bar_holder.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String name = '/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
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
                  Text("Get Started with",style: Theme.of(context).textTheme.titleLarge,),
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
                  TextFormField(
                    controller: _passwordTEController,
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      hintText: "Password",
                    ),
                    validator: (String? value){
                      if((value?.length ?? 0) <=6 ){
                        return "Enter valid Password";
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
    Navigator.pushNamedAndRemoveUntil(context, MainNavBarHolder.name, (predicate)=> false);
  }

  @override
  void dispose() {
   _emailTEController.dispose();
   _passwordTEController.dispose();
    super.dispose();
  }
}
