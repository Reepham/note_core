import 'package:flutter/material.dart';

class HomeBottomBar extends StatefulWidget {
  const HomeBottomBar({Key? key}) : super(key: key);

  @override
  State<HomeBottomBar> createState() => _HomeBottomBarState();
}

class _HomeBottomBarState extends State<HomeBottomBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Notizen',
          backgroundColor: Colors.grey,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_task_outlined),
          label: 'Aufgabe',
          backgroundColor: Colors.grey,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Einstellungen',
          backgroundColor: Colors.grey,
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }
}
