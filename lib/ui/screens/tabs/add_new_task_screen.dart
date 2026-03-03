import 'package:flutter/material.dart';
import 'package:ostad_tm/ui/widgets/screen_background.dart';
import 'package:ostad_tm/ui/widgets/tm_app_bar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  static const String name = "/AddNewTaskScreen";

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  TextEditingController _titleTEController = TextEditingController();
  TextEditingController _descriptionTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: ScreenBackground(
          child : Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: .center,
                children: [
                  const SizedBox(height: 40,),
                  Text("Add New Task",style: Theme.of(context).textTheme.titleLarge,),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _titleTEController,
                    decoration: InputDecoration(
                      hintText: "Title",
                    ),
                    validator: (String? value){
                      if(value?.trim().isEmpty ?? true){
                         return "Enter your Title";
                      } return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _descriptionTEController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: "Description",
                      contentPadding: EdgeInsets.all(8)
                    ),
                    validator: (String? value){
                      if(value?.trim().isEmpty ?? true){
                        return "Enter your Description";
                      } return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(onPressed: _onTapAddTsk, child: Text("Add Task")),

                ],
              ),
            ),
          )
      ),
    );
  }

  void _onTapAddTsk(){
    if(_formKey.currentState!.validate()){
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _titleTEController.dispose;
    _descriptionTEController.dispose;
    super.dispose();
  }
}
