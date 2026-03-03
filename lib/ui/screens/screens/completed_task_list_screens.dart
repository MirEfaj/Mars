import 'package:flutter/material.dart';
import '../../widgets/task_card.dart';


class CompletedTaskListScreens extends StatelessWidget {
  const CompletedTaskListScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index){
                  return TaskCard(
                      taskType: TaskType.completed
                  );
                }),
          )
        ],
      ),
    );
  }



}




