import 'package:HaniNotes/Pages/NotizenPage.dart';
import 'package:HaniNotes/Pages/SettingsPage.dart';
import 'package:HaniNotes/Provider/BottomMenuChanger.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeBottomBar extends StatefulWidget {
  const HomeBottomBar({Key? key}) : super(key: key);

  @override
  State<HomeBottomBar> createState() => _HomeBottomBarState();
}

class _HomeBottomBarState extends State<HomeBottomBar> {
  late int _selectedIndex;
  late BottomMenuChanger indexChanger;

  void _onItemTapped(int index) {
    if (_selectedIndex == index) {
      return;
    }

    indexChanger.setIndex(index);
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => const NotizenPage(title: "HaniNotes")),
          (Route<dynamic> route) => false,
        );
        break;
      case 1:
        break;
      case 2:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => const SettingsPage(title: "HaniNotes")),
          (Route<dynamic> route) => false,
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    indexChanger = Provider.of<BottomMenuChanger>(context);
    _selectedIndex = indexChanger.getIndex();
    return BottomNavigationBar(
      // selectedItemColor: Theme.of(context).colorScheme.onBackground,
      // unselectedItemColor: Theme.of(context).colorScheme.onBackground,
      // backgroundColor: Theme.of(context).primaryColor,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Notizen',
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.add_task_outlined), label: 'Aufgabe'),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Einstellungen',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      onTap: _onItemTapped,
    );
  }
}
