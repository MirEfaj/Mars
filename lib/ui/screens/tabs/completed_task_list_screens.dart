import 'package:flutter/material.dart';
import '../../../data/models/task_model.dart';
import '../../../data/service/network_caller.dart';
import '../../../data/urls.dart';
import '../../widgets/centered_circular_prosgress_indicator.dart';
import '../../widgets/show_snack_bar_msg.dart';
import '../../widgets/task_card.dart';


class CompletedTaskListScreens extends StatefulWidget {
  const CompletedTaskListScreens({super.key});

  @override
  State<CompletedTaskListScreens> createState() => _CompletedTaskListScreensState();
}

class _CompletedTaskListScreensState extends State<CompletedTaskListScreens> {
  bool _getCompletedTasksInProgress = false;
  List<TaskModel> _completedTaskList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _getCompletedTaskList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: Visibility(
              visible: _getCompletedTasksInProgress == false,
              replacement: CenteredCircularProgressIndicator(),
              child: ListView.builder(
                  itemCount: _completedTaskList.length,
                  itemBuilder: (context, index){
                    return TaskCard(
                      taskType: TaskType.completed, taskModel: _completedTaskList[index], onStatusUpdate: () {  _getCompletedTaskList(); },
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }


  Future<void> _getCompletedTaskList() async{
    _getCompletedTasksInProgress = true;
    setState(() { });
    NetworkResponse response = await NetworkCaller.getRequest(url: Urls.gteCompletedTaskUrl);
    if(response.isSuccess){
      List<TaskModel> list = [];
      for(Map<String, dynamic> jsonData in response.body!["data"]){
        list.add(TaskModel.fromJson(jsonData));
      }
      _completedTaskList = list;

    }else{
      showSnackBarMessage(context, response.errorMessage!);
    }
    _getCompletedTasksInProgress = false;
    setState(() { });
  }

}




