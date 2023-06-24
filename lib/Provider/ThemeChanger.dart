import 'package:flutter/material.dart';


class ThemeChanger with ChangeNotifier{

  ThemeData _themeData;
  Color _seedColor;
  ThemeChanger(this._themeData,this._seedColor);

  getTheme() => _themeData;
  getSeedColor() => _seedColor;
  setTheme (ThemeData theme,Color seed) {
    _themeData = theme;
    _seedColor = seed;
    notifyListeners();
  }

}