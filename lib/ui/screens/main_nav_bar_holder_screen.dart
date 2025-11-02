import 'package:flutter/material.dart';
import 'package:practice/ui/screens/cancelled_screen.dart';
import 'package:practice/ui/screens/completed_screen.dart';
import 'package:practice/ui/screens/home_screen.dart';

import '../widgets/tm_app_bar.dart';

class MainNavBarHolderScreen extends StatefulWidget {
  const MainNavBarHolderScreen({super.key});

  @override
  State<MainNavBarHolderScreen> createState() => _MainNavBarHolderScreenState();
}

class _MainNavBarHolderScreenState extends State<MainNavBarHolderScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    HomeScreen(),
    CompletedScreen(),
    CancelledTaskScreen(),
    CompletedScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),

      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          _selectedIndex = index;
          setState(() {});
        },
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.refresh), label: 'Progress'),
          NavigationDestination(icon: Icon(Icons.cancel), label: 'Cancelled'),
          NavigationDestination(
            icon: Icon(Icons.done_outline),
            label: 'Completed',
          ),
        ],
      ),
      body: _screens[_selectedIndex],
    );
  }
}
