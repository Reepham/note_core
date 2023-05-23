import 'package:flutter/material.dart';


class BottomMenuChanger with ChangeNotifier{

  int index;

  BottomMenuChanger(this.index);

  getIndex() => index;

  setIndex (int newIndex) {
    index = newIndex;

    notifyListeners();
  }

}