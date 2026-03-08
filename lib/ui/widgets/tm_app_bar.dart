import 'package:flutter/material.dart';
import 'package:ostad_tm/ui/controllers/auth_controller.dart';
import 'package:ostad_tm/ui/screens/sign_in_screen.dart';
import 'package:ostad_tm/ui/screens/update_profile_screen.dart';
import 'package:ostad_tm/app.dart';

class TMAppBar extends StatefulWidget implements PreferredSizeWidget{
  const TMAppBar({
    super.key,
  });

  @override
  State<TMAppBar> createState() => _TMAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _TMAppBarState extends State<TMAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      title: Row(
        children: [
          GestureDetector(
              onTap: onTapProfileBar,
              child: CircleAvatar()),
          SizedBox(width: 10,),
          Column(
            crossAxisAlignment: .start,
            children: [
              Text(AuthController.userModel!.fullName, style: TextStyle(fontSize: 14, fontWeight: .w500 , color: Colors.white),),
              Text(AuthController.userModel!.email, style: TextStyle(fontSize: 12, fontWeight: .w400 , color: Colors.white),),
            ],
          ),
          Spacer(),
          IconButton(onPressed: onTapLogoutButton, icon: Icon(Icons.login_outlined,))
        ],
      ),);
  }

  Future<void> onTapLogoutButton() async{
    await AuthController.clearData();
    Navigator.pushNamedAndRemoveUntil(context, SignInScreen.name, (predicate)=> false);
  }


  void onTapProfileBar(){
   if(ModalRoute.of(context)!.settings.name != UpdateProfileScreen.name){
     Navigator.pushNamed(context, UpdateProfileScreen.name);
   }

  }

}