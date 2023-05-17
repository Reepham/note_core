import 'package:flutter/material.dart';

import 'Pages/NotizenPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
 const MyApp({Key? key}) : super(key: key);
 final MaterialColor _primarySwatch = Colors.red;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HaniNotes',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: _primarySwatch,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: _primarySwatch,
      ),
      themeMode: ThemeMode.dark,
      home: const Notizen(title: 'HaniNotes'),
    );
  }
}
