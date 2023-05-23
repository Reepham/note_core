import 'package:HaniNotes/Provider/BottomMenuChanger.dart';
import 'package:HaniNotes/Provider/ThemeChanger.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Pages/NotizenPage.dart';

MaterialColor getMaterialColor(Color color) {
  final int red = color.red;
  final int green = color.green;
  final int blue = color.blue;
  final int alpha = color.alpha;

  final Map<int, Color> shades = {
    50: Color.fromARGB(alpha, red, green, blue),
    100: Color.fromARGB(alpha, red, green, blue),
    200: Color.fromARGB(alpha, red, green, blue),
    300: Color.fromARGB(alpha, red, green, blue),
    400: Color.fromARGB(alpha, red, green, blue),
    500: Color.fromARGB(alpha, red, green, blue),
    600: Color.fromARGB(alpha, red, green, blue),
    700: Color.fromARGB(alpha, red, green, blue),
    800: Color.fromARGB(alpha, red, green, blue),
    900: Color.fromARGB(alpha, red, green, blue),
  };

  return MaterialColor(color.value, shades);
}

Future<ThemeData> _loadSettings() async {
  final prefs = await SharedPreferences.getInstance();
  Brightness brightness =
      Brightness.values[prefs.getInt('brightness') ?? Brightness.light.index];
  Color color = Color(prefs.getInt('color') ?? Colors.blue.value);

  return ThemeData(
      brightness: brightness, primarySwatch: getMaterialColor(color));
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  _loadSettings().then((themeData) => runApp(MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeChanger(themeData)),
          ChangeNotifierProvider(create: (_) => BottomMenuChanger(0)),
        ],
        child: const MyApp(),
      )));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HaniNotes',
      theme: context.watch<ThemeChanger>().getTheme(),
      home: const NotizenPage(title: 'HaniNotes'),
    );
  }
}
