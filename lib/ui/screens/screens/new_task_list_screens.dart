import 'package:flutter/material.dart';

import '../../widgets/task_card.dart';
import '../../widgets/task_count_summary.dart';

class NewTaskListScreens extends StatelessWidget {
  const NewTaskListScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [

            SizedBox(
              height: 100,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context ,index){
                  return TaskCountSummeryCard(title: 'Progress', count: 12,);
                }, separatorBuilder: (BuildContext context, int index)
              { return const SizedBox(width: 8,); },
                itemCount: 4,),
            ),
            SizedBox(height: 10,),
            Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index){
                    return TaskCard();
                  }),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: _onTapAddNewTaskButton, child: Icon(Icons.add),),
    );
  }


  void _onTapAddNewTaskButton(){

  }
}




