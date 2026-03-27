import 'package:flutter/material.dart';
import 'package:ostad_tm/data/models/task_model.dart';
import 'package:ostad_tm/data/service/network_caller.dart';
import 'package:ostad_tm/ui/widgets/centered_circular_prosgress_indicator.dart';
import 'package:ostad_tm/ui/widgets/show_snack_bar_msg.dart';

import '../../data/urls.dart';

enum TaskType { tNew, progress, completed, cancelled }

class TaskCard extends StatefulWidget {
  const TaskCard({super.key, required this.taskType, required this.taskModel, required this.onStatusUpdate});
  final TaskType taskType;
  final TaskModel taskModel;
  final VoidCallback onStatusUpdate;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _updateTaskStatusInProgress = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              widget.taskModel.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(widget.taskModel.description),
            Text(
              "Date : ${widget.taskModel.createdDate}",
              style: TextStyle(color: Colors.black54),
            ),
            Row(
              children: [
                Chip(
                  label: Text(
                    _getTaskTypeName(),
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: _getTaskChipColor(),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide.none,
                  ),
                ),
                Spacer(),
                Visibility(
                  visible: _updateTaskStatusInProgress == false,
                  replacement: CenteredCircularProgressIndicator(),
                  child: IconButton(
                    onPressed: () {
                      _showEditTaskStatusDialog();
                    },
                    icon: Icon(Icons.edit),
                  ),
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Color _getTaskChipColor(){
  Color _getTaskChipColor() {
    switch (widget.taskType) {
      case TaskType.tNew:
        return Colors.blue;
      case TaskType.progress:
        return Colors.purple;
      case TaskType.completed:
        return Colors.green;
      case TaskType.cancelled:
        return Colors.redAccent;
    }
  }

  String _getTaskTypeName() {
    switch (widget.taskType) {
      case TaskType.tNew:
        return "New";
      case TaskType.progress:
        return "Progress";
      case TaskType.completed:
        return "Completed";
      case TaskType.cancelled:
        return "Cancelled";
    }
  }

  void _showEditTaskStatusDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text("Change Status"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text("New"),
                trailing: _getTaskStatusTrailing(TaskType.tNew),
                onTap: () {
                  if(widget.taskType == TaskType.tNew){
                    return ;
                  }
                  _updateTaskStatus("New");
                },
              ),
              ListTile(
                title: Text("Progress"),
                trailing: _getTaskStatusTrailing(TaskType.progress),
                onTap: () {
                  if(widget.taskType == TaskType.progress){
                    return ;
                  }
                  _updateTaskStatus("Progress");
                },
              ),
              ListTile(
                title: Text("Completed"),
                trailing: _getTaskStatusTrailing(TaskType.completed),
                onTap: () {
                  if(widget.taskType == TaskType.completed){
                    return ;
                  }
                  _updateTaskStatus("Completed");
                },
              ),
              ListTile(
                title: Text("Cancelled"),
                trailing: _getTaskStatusTrailing(TaskType.cancelled),
                onTap: () {
                  if(widget.taskType == TaskType.cancelled){
                    return ;
                  }
                  _updateTaskStatus("Cancelled");
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget? _getTaskStatusTrailing(TaskType type) {
    return widget.taskType == type ? Icon(Icons.check) : null;
  }

  Future<void> _updateTaskStatus(String status) async {
    Navigator.of(context).pop();
    _updateTaskStatusInProgress = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.updateTaskStatus(widget.taskModel.id, status),
    );
    if (response.isSuccess) {
      widget.onStatusUpdate();
    } else {
      if (mounted) {
        showSnackBarMessage(context, response.errorMessage!);
      }
    }
    _updateTaskStatusInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }
}
