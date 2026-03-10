import 'package:flutter/material.dart';
import 'package:ostad_tm/ui/widgets/centered_circular_prosgress_indicator.dart';

import '../../../data/models/task_model.dart';
import '../../../data/service/network_caller.dart';
import '../../../data/urls.dart';
import '../../widgets/show_snack_bar_msg.dart';
import '../../widgets/task_card.dart';
import '../../widgets/task_count_summary.dart';

class ProgressTaskListScreens extends StatefulWidget {
  const ProgressTaskListScreens({super.key});

  @override
  State<ProgressTaskListScreens> createState() => _ProgressTaskListScreensState();
}

class _ProgressTaskListScreensState extends State<ProgressTaskListScreens> {
  bool _getProgressTasksInProgress = false;
  List<TaskModel> _progressTaskList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _getNewTaskList();
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
              visible: _getProgressTasksInProgress == false,
              replacement: CenteredCircularProgressIndicator(),
              child: ListView.builder(
                  itemCount: _progressTaskList.length,
                  itemBuilder: (context, index){
                    return TaskCard(
                        taskType: TaskType.progress, taskModel: _progressTaskList[index],
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _getNewTaskList() async{
    _getProgressTasksInProgress = true;
    setState(() { });
    NetworkResponse response = await NetworkCaller.getRequest(url: Urls.gteProgressTaskUrl);
    if(response.isSuccess){
      List<TaskModel> list = [];
      for(Map<String, dynamic> jsonData in response.body!["data"]){
        list.add(TaskModel.fromJson(jsonData));
      }
      _progressTaskList = list;

    }else{
      showSnackBarMessage(context, response.errorMessage!);
    }
    _getProgressTasksInProgress = false;
    setState(() { });
  }
}




