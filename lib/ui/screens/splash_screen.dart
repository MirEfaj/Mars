import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ostad_tm/ui/screens/sign_in_screen.dart';
import 'package:ostad_tm/ui/widgets/screen_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String name = '/splash-screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Future<void> _moveToNextScreen() async{
    await Future.delayed(Duration(seconds: 2));
 //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInScreen()));
    Navigator.pushReplacementNamed(context, SignInScreen.name);
  }

  @override
  void initState() {
    _moveToNextScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBackground(
        child:   Align(
            alignment: Alignment.center,
            child: SvgPicture.asset("assets/images/logo.svg")),
    );
  }
}
