
import 'package:HaniNotes/Provider/ThemeChanger.dart';
import 'package:flutter/material.dart';
import 'package:HaniNotes/ReusableWidgets/HomeBottomBar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  Future<void> _saveSetting(ThemeData setting) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setInt('brightness', setting.brightness.index);
      prefs.setInt('color', setting.primaryColor.value);
    });
  }


  @override
  Widget build(BuildContext context) {
    ThemeChanger themeChanger = Provider.of<ThemeChanger>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              leading: const Icon(Icons.brightness_3, size: 50.0),
              title: const Text("Dark Mode"),
              subtitle: const Text("Aktiviert den dunklen Modus"),
              onTap: () {
                themeChanger.setTheme(ThemeData.dark());
                _saveSetting(themeChanger.getTheme());
              },
            )
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.brightness_5, size: 50.0),
              title: const Text("Light Mode"),
              subtitle: const Text("Aktiviert den hellen Modus"),
              onTap: () {
                themeChanger.setTheme(ThemeData.light());
                _saveSetting(themeChanger.getTheme());
              },
            )
          ),
        ],
      ),
      bottomNavigationBar: const HomeBottomBar(),
    );
  }
}
