import 'package:flutter/material.dart';

class Settings {
  Color color;
  Brightness brightness;
  
  Settings({
    required this.color,
    required this.brightness,
  });
}

class CustomThemeData {
  Color seedColor;
  ThemeData generatedTheme;
  
  CustomThemeData({
    required this.seedColor,
    required this.generatedTheme,
  });
}