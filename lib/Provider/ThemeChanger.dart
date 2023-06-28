import 'package:flutter/material.dart';


class ThemeChanger with ChangeNotifier{

  ThemeData _themeData;
  Color _seedColor;
  ThemeChanger(this._themeData,this._seedColor);

  ThemeData getTheme() => _themeData;
  Color getSeedColor() => _seedColor;
  setTheme (ThemeData theme,Color seed) {
    _themeData = theme;
    _seedColor = seed;
    notifyListeners();
  }

}