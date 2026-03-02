import 'package:flutter/material.dart';

class TaskCountSummeryCard extends StatelessWidget {
  const TaskCountSummeryCard({
    super.key, required this.title, required this.count,
  });
  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(count.toString(), style: Theme.of(context).textTheme.titleLarge,),
            Text(title, style: Theme.of(context).textTheme.titleSmall, maxLines: 1),
          ],
        ),
      ),
    );
  }
}