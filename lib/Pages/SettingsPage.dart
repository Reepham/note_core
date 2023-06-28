import 'package:HaniNotes/Provider/ThemeChanger.dart';
import 'package:HaniNotes/main.dart';
import 'package:flutter/material.dart';
import 'package:HaniNotes/ReusableWidgets/HomeBottomBar.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Future<void> _saveSetting(ThemeData themeData, Color seedColor) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setInt('brightness', themeData.brightness.index);
      prefs.setInt('color', seedColor.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeChanger themeChanger = Provider.of<ThemeChanger>(context);
    Color newColor = themeChanger.getSeedColor();

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
              ThemeData newTheme = ThemeData(
                  colorSchemeSeed: themeChanger.getSeedColor(),
                  brightness: Brightness.dark);
              themeChanger.setTheme(newTheme, themeChanger.getSeedColor());
              _saveSetting(newTheme, themeChanger.getSeedColor());
            },
          )),
          Card(
              child: ListTile(
            leading: const Icon(Icons.brightness_5, size: 50.0),
            title: const Text("Light Mode"),
            subtitle: const Text("Aktiviert den hellen Modus"),
            onTap: () {
              ThemeData newTheme = ThemeData(
                  colorSchemeSeed: themeChanger.getSeedColor(),
                  brightness: Brightness.light);
              themeChanger.setTheme(newTheme, themeChanger.getSeedColor());
              _saveSetting(newTheme, themeChanger.getSeedColor());
            },
          )),
          Card(
              child: ListTile(
            leading: const Icon(Icons.color_lens, size: 50.0),
            title: const Text("Farbe ändern"),
            subtitle: const Text("Das Farbschema der App anpassen"),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Wähle eine Farbe!'),
                      content: SingleChildScrollView(
                        child: ColorPicker(
                          pickerColor:
                              themeChanger.getSeedColor(), //default color
                          onColorChanged: (Color color) {
                            //on color picked
                            setState(() {
                              newColor = color;
                              ThemeData newTheme = ThemeData(
                                  colorSchemeSeed: color,
                                  brightness:
                                      themeChanger.getTheme().brightness);
                              themeChanger.setTheme(newTheme, newColor);
                            });
                          },
                        ),
                      ),
                      actions: <Widget>[
                        ElevatedButton(
                          child: const Text('Fertig!'),
                          onPressed: () {
                            _saveSetting(themeChanger.getTheme(), newColor);
                            Navigator.of(context)
                                .pop(); //dismiss the color picker
                          },
                        ),
                      ],
                    );
                  });
            },
          )),
        ],
      ),
      bottomNavigationBar: const HomeBottomBar(),
    );
  }
}
