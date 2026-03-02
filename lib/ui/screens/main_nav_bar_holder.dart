import 'package:flutter/material.dart';
import 'package:ostad_tm/ui/screens/screens/new_task_list_screens.dart';
import 'package:ostad_tm/ui/screens/screens/progress_task_list_screens.dart';

import '../widgets/tm_app_bar.dart';

class MainNavBarHolder extends StatefulWidget {
  const MainNavBarHolder({super.key});

  static const String name = '/MainNavBarHolder';

  @override
  State<MainNavBarHolder> createState() => _MainNavBarHolderState();
}

class _MainNavBarHolderState extends State<MainNavBarHolder> {
  final List<Widget> _screens =[
    NewTaskListScreens(),
    ProgressTaskListScreens(),
    NewTaskListScreens(),
    NewTaskListScreens(),
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
          onDestinationSelected: (int index){
          setState(() {
            _selectedIndex = index;
          });
          },
          destinations: [
        NavigationDestination(icon: Icon(Icons.new_label_outlined), label: "New"),
        NavigationDestination(icon: Icon(Icons.update), label: "Progress" ),
        NavigationDestination(icon: Icon(Icons.done), label: "Completed"),
        NavigationDestination(icon: Icon(Icons.close), label: "Canceled" ),
      ]),
    );
  }
}



