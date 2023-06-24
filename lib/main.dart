import 'package:HaniNotes/Models/Settings.dart';
import 'package:HaniNotes/Provider/BottomMenuChanger.dart';
import 'package:HaniNotes/Provider/ThemeChanger.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Pages/NotizenPage.dart';

Future<CustomThemeData> _loadSettings() async {
  final prefs = await SharedPreferences.getInstance();
  Brightness brightness =
      Brightness.values[prefs.getInt('brightness') ?? Brightness.light.index];
  Color color = Color(prefs.getInt('color') ?? Colors.blue.value);
  ThemeData theme=ThemeData(
      brightness: brightness, colorSchemeSeed: color );
  return CustomThemeData(seedColor: color, generatedTheme: theme);
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  _loadSettings().then((themeData) => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeChanger(themeData.generatedTheme,themeData.seedColor)),
          ChangeNotifierProvider(create: (_) => BottomMenuChanger(0)),
        ],
        child: const MyApp()
      )));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HaniNotes',
      theme: Provider.of<ThemeChanger>(context).getTheme(),
      home: const NotizenPage(title: 'HaniNotes'),
    );
  }
}