import 'package:flutter/material.dart';
import 'package:ostad_tm/data/models/task_model.dart';
import 'package:ostad_tm/data/models/task_status_count_model.dart';
import 'package:ostad_tm/data/service/network_caller.dart';
import 'package:ostad_tm/ui/widgets/centered_circular_prosgress_indicator.dart';
import 'package:ostad_tm/ui/widgets/show_snack_bar_msg.dart';

import '../../../data/urls.dart';
import '../../widgets/task_card.dart';
import '../../screens/tabs/add_new_task_screen.dart';
import '../../widgets/task_count_summary.dart';

class NewTaskListScreens extends StatefulWidget {
  const NewTaskListScreens({super.key});

  @override
  State<NewTaskListScreens> createState() => _NewTaskListScreensState();
}

class _NewTaskListScreensState extends State<NewTaskListScreens> {
  bool _getNewTasksInProgress = false;
  bool _getTaskStatusCountInProgress = false;
  List<TaskModel> _newTaskList = [];
  List<TaskStatusCountModel> _taskStatusCountList = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _getNewTaskList();
      taskStatusCountList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 100,
              child: Visibility(
                visible: _getTaskStatusCountInProgress == false,
                replacement: CenteredCircularProgressIndicator(),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return TaskCountSummeryCard(
                      title: _taskStatusCountList[index].id,
                      count: _taskStatusCountList[index].count,
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(width: 8);
                  },
                  itemCount: _taskStatusCountList.length,
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Visibility(
                visible: _getNewTasksInProgress == false,
                replacement: CenteredCircularProgressIndicator(),
                child: ListView.builder(
                  itemCount: _newTaskList.length,
                  itemBuilder: (context, index) {
                    return TaskCard(
                      taskType: TaskType.tNew,
                      taskModel: _newTaskList[index],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onTapAddNewTaskButton(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _onTapAddNewTaskButton(context) {
    Navigator.pushNamed(context, AddNewTaskScreen.name);
  }

  Future<void> taskStatusCountList() async {
    _getTaskStatusCountInProgress = true;
    setState(() {});
    NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.taskStatusCountUrl,
    );
    if (response.isSuccess) {
      List<TaskStatusCountModel> list = [];
      for (Map<String, dynamic> jsonData in response.body!["data"]) {
        list.add(TaskStatusCountModel.fromJson(jsonData));
      }
      _taskStatusCountList = list;
    } else {
      showSnackBarMessage(context, response.errorMessage!);
    }
    _getTaskStatusCountInProgress = false;
    setState(() {});
  }

  Future<void> _getNewTaskList() async {
    _getNewTasksInProgress = true;
    setState(() {});
    NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.gteNewTaskUrl,
    );
    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.body!["data"]) {
        list.add(TaskModel.fromJson(jsonData));
      }
      _newTaskList = list;
    } else {
      if(mounted){
        showSnackBarMessage(context, response.errorMessage!);
      }
    }
    _getNewTasksInProgress = false;
    if(mounted){
      setState(() {});
    }

  }
}
