import 'package:flutter/material.dart';
import 'package:ostad_tm/ui/screens/sign_in_screen.dart';

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
          CircleAvatar(),
          SizedBox(width: 10,),
          Column(
            crossAxisAlignment: .start,
            children: [
              Text("Md Efaj Alam", style: TextStyle(fontSize: 14, fontWeight: .w500 , color: Colors.white),),
              Text("mdefaj25@gmail.com", style: TextStyle(fontSize: 12, fontWeight: .w400 , color: Colors.white),),
            ],
          ),
          Spacer(),
          IconButton(onPressed: onTapLogoutButton, icon: Icon(Icons.login_outlined,))
        ],
      ),);
  }

  void onTapLogoutButton(){
    Navigator.pushNamedAndRemoveUntil(context, SignInScreen.name, (predicate)=> false);
  }


}