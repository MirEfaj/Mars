import 'package:flutter/material.dart';

import '../../widgets/task_card.dart';
import '../../widgets/task_count_summary.dart';

class ProgressTaskListScreens extends StatelessWidget {
  const ProgressTaskListScreens({super.key});

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
                  return TaskCard();
                }),
          )
        ],
      ),
    );
  }



}




