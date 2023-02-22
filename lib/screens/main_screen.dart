import 'package:flutter/material.dart';
import 'package:image_saver/screens/actor_screen.dart';
import 'package:image_saver/screens/form_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  List pages = [
    FormScreen(),
    ActorScreen(),
  ];

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 10,
        selectedItemColor: Colors.pinkAccent,
        unselectedItemColor: Colors.black,
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        showUnselectedLabels: true,
        currentIndex: currentIndex,
        onTap: onTap,
        items: [
          BottomNavigationBarItem(
            label: 'Add Actor',
            icon: Icon(
              Icons.add,
              size: 20,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Favourtie Actor',
            icon: Icon(
              Icons.person,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
