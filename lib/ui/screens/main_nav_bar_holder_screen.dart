import 'package:flutter/material.dart';
import 'package:practice/ui/screens/progress_task_screen.dart';
import 'package:practice/ui/screens/update_profile_screen.dart';

import '../widgets/tm_app_bar.dart';
import 'cancelled_screen.dart';
import 'completed_screen.dart';
import 'new_task_screen.dart';

class MainNavBarHolderScreen extends StatefulWidget {
  const MainNavBarHolderScreen({super.key});

  @override
  State<MainNavBarHolderScreen> createState() => _MainNavBarHolderScreenState();
}

class _MainNavBarHolderScreenState extends State<MainNavBarHolderScreen> {
  // _onTapAppBar() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => UpdateProfileScreen()),
  //   );
  //   setState(() {
  //
  //   });
  // }

  int _selectedIndex = 0;

  final List<Widget> _screens = [
    NewTaskScreen(),
    ProgressTaskScreen(),
    CancelledTaskScreen(),
    CompletedScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    if (_selectedIndex == 0) {
      String cheapText = 'New';
      setState(() {});
    }

    return Scaffold(
      appBar: TMAppBar(),
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          _selectedIndex = index;
          setState(() {});
        },
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.new_label_outlined),
            label: 'New',
          ),
          NavigationDestination(icon: Icon(Icons.refresh), label: 'Progress'),
          NavigationDestination(icon: Icon(Icons.close), label: 'Cancelled'),
          NavigationDestination(icon: Icon(Icons.done), label: 'Completed'),
        ],
      ),
    );
  }
}
