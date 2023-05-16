import 'package:flutter/material.dart';

import 'Pages/NotizenPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HaniNotes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Notizen(title: 'HaniNotes'),
    );
  }
}
