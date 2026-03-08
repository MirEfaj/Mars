import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ostad_tm/data/service/network_caller.dart';
import 'package:ostad_tm/ui/screens/sign_in_screen.dart';
import 'package:ostad_tm/ui/widgets/screen_background.dart';
import 'package:ostad_tm/ui/widgets/show_snack_bar_msg.dart';

import '../../data/urls.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String name = '/sign-up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstTEController = TextEditingController();
  final TextEditingController _lastTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _forKey = GlobalKey<FormState>();
  bool _signUpInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _forKey,
        //      autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  SizedBox(height: 80,),
                  Text("Join With Us",style: Theme.of(context).textTheme.titleLarge,),
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
                    controller: _firstTEController,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: "First Name",
                    ),
                    validator: (String? value){
                      if((value?.length ?? 0) <=3 ){
                        return "Enter your First Name";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: _lastTEController,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: "Last Name",
                    ),
                    validator: (String? value) {
                      if ((value?.length ?? 0) <= 3) {
                        return "Enter your Last Name";
                      }
                      return null;
                    }
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: _mobileTEController,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: "Mobile",
                    ),
                    validator: (String? value){
                      if((value?.length ?? 0) <=6 ){
                        return "Enter valid Mobile Number";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: _passwordTEController,
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.visiblePassword,
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
                  Visibility(
                    visible: _signUpInProgress == false,
                    replacement: Center(child: CircularProgressIndicator(),),
                    child: ElevatedButton(
                      onPressed: _onTapSignUpButton,
                      child: Icon(Icons.arrow_circle_right_outlined, size: 20,),
                    ),
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
                        recognizer: TapGestureRecognizer()..onTap = _onTapLogInButton
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
    if(_forKey.currentState!.validate()){
      _signUp();
    }
  }

  Future<void> _signUp() async{
    _signUpInProgress = true;
    setState(() {   });
    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "firstName":_firstTEController.text.trim(),
      "lastName":_lastTEController.text.trim(),
      "mobile":_mobileTEController.text.trim(),
      "password":_passwordTEController.text
    };
    NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.registration,
      body: requestBody
    );
    if(response.isSuccess){
      Navigator.pushNamedAndRemoveUntil(context, SignInScreen.name, (predicate)=> false);
        showSnackBarMessage(context, "Successfully registration completed, Please log-In");
        _cleatTextFields();
    }else{
      showSnackBarMessage(context, response.errorMessage!);
    }
    _signUpInProgress = false;
    setState(() {   });

  }

  void _onTapLogInButton(){
      Navigator.pushNamedAndRemoveUntil(context, SignInScreen.name, (predicate)=> false);
  }

  void _cleatTextFields(){
    _emailTEController.clear();
    _passwordTEController.clear();
    _firstTEController.clear();
    _lastTEController.clear();
    _mobileTEController.clear();
}

  @override
  void dispose() {
   _emailTEController.dispose();
   _passwordTEController.dispose();
   _firstTEController.dispose();
   _lastTEController.dispose();
   _mobileTEController.dispose();
    super.dispose();
  }
}
