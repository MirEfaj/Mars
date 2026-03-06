import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ostad_tm/ui/screens/sign_in_screen.dart';
import 'package:ostad_tm/ui/widgets/screen_background.dart';
import '../widgets/tm_app_bar.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  static const String name = '/UpdateProfileScreen';

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstTEController = TextEditingController();
  final TextEditingController _lastTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _forKey = GlobalKey<FormState>();
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
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
                  Text("Profile Update",style: Theme.of(context).textTheme.titleLarge,),
                  SizedBox(height: 20,),
                  _buildPhotoPicker(),
                  const SizedBox(height: 10,),
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
                      if((value?.length ?? 0) <=6 ){
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
                      if ((value?.length ?? 0) <= 6) {
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
                  ElevatedButton(
                    onPressed: _onTapSignUpButton,
                    child: Icon(Icons.arrow_circle_right_outlined, size: 20,),
                  ),

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
      // to do sign in
    }
  }


  Widget _buildPhotoPicker(){
    return GestureDetector(
      onTap: _onTapPhotoPicker,
      child: Container(
        height: 50,
        width: double.maxFinite,
        color: Colors.white,
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  )
              ),
              child: Text("Photo",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),),
            ),
            SizedBox(width: 10,),
            Text( _selectedImage == null ? "Select Image" : _selectedImage!.name,  maxLines: 1,style: TextStyle(
              overflow: TextOverflow.ellipsis
            ),)

          ],
        ),
      ),
    );
  }

  Future<void> _onTapPhotoPicker() async{
     final XFile? pickImage = await _imagePicker.pickImage(source: ImageSource.camera);
     if(pickImage != null){
       _selectedImage = pickImage;
       setState(() {  });
     }
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
