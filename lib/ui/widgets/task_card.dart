import 'package:flutter/material.dart' ;

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text("Title will be here", style: Theme.of(context).textTheme.titleLarge,),
              Text("Description"),
              Text("Date : 12/120/2026", style: TextStyle(color: Colors.black54),),
              Row(
                children: [
                  Chip(label: Text("New",style: TextStyle( color: Colors.white),),
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)
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
}