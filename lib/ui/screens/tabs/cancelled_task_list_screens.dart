import 'package:flutter/material.dart';
import '../../../data/models/task_model.dart';
import '../../../data/service/network_caller.dart';
import '../../../data/urls.dart';
import '../../widgets/centered_circular_prosgress_indicator.dart';
import '../../widgets/show_snack_bar_msg.dart';
import '../../widgets/task_card.dart';


class CancelledTaskListScreens extends StatefulWidget {
  const CancelledTaskListScreens({super.key});

  @override
  State<CancelledTaskListScreens> createState() => _CancelledTaskListScreensState();
}

class _CancelledTaskListScreensState extends State<CancelledTaskListScreens> {
  bool _getCancelledTasksInProgress = false;
  List<TaskModel> _cancelledTaskList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _getCancelledTaskList();
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
              visible: _getCancelledTasksInProgress == false,
              replacement: CenteredCircularProgressIndicator(),
              child: ListView.builder(
                  itemCount: _cancelledTaskList.length,
                  itemBuilder: (context, index){
                    return TaskCard(
                      taskType: TaskType.cancelled, taskModel: _cancelledTaskList[index], onStatusUpdate: () { _getCancelledTaskList(); },
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }


  Future<void> _getCancelledTaskList() async{
    _getCancelledTasksInProgress = true;
    setState(() { });
    NetworkResponse response = await NetworkCaller.getRequest(url: Urls.gteCancelledTaskUrl);
    if(response.isSuccess){
      List<TaskModel> list = [];
      for(Map<String, dynamic> jsonData in response.body!["data"]){
        list.add(TaskModel.fromJson(jsonData));
      }
      _cancelledTaskList = list;

    }else{
      showSnackBarMessage(context, response.errorMessage!);
    }
    _getCancelledTasksInProgress = false;
    setState(() { });
  }

}




