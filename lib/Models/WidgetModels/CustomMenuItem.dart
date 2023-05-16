import 'package:flutter/material.dart';

class CustomMenuItem {
  final String text;
  final IconData icon;
  Function onTap;
  
  CustomMenuItem({
    required this.text,
    required this.icon,
    required this.onTap,
  });
}