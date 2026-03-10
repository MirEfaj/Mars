import 'package:flutter/material.dart' ;
import 'package:ostad_tm/data/models/task_model.dart';

enum TaskType{ tNew , progress, completed , cancelled}

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.taskType, required this.taskModel,});
  final TaskType taskType;
  final TaskModel taskModel;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text(taskModel.title, style: Theme.of(context).textTheme.titleLarge,),
              Text(taskModel.description),
              Text("Date : ${taskModel.createdDate}", style: TextStyle(color: Colors.black54),),
              Row(
                children: [
                  Chip(label: Text(_getTaskTypeName(),style: TextStyle( color: Colors.white),),
                    backgroundColor: _getTaskChipColor(),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide.none
                    ),),
                  Spacer(),
                  IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
                  IconButton(onPressed: (){}, icon: Icon(Icons.delete)),
                ],
              )
            ],
          ),
        )
    );
  }
  // Color _getTaskChipColor(){
  //   if(taskType == TaskType.tNew){
  //     return Colors.blue;
  //   }else if(taskType == TaskType.progress){
  //     return Colors.purple;
  //   }else if(taskType == TaskType.completed){
  //     return Colors.green;
  //   }else{
  //     return Colors.red;
  //   }
  // }

  Color _getTaskChipColor(){
    switch(taskType){
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

    String _getTaskTypeName(){
      switch(taskType){
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






}