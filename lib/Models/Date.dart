import 'package:flutter/material.dart';

class Date{
  int year;
  int month;
  int day;

  Date({
    this.day = 01,
    this.month = 01,
    this.year= 2023
  });

  static Date getDate(DateTime dt){
    return Date(day: dt.day,month: dt.month, year: dt.year);
  }

  @override toString() {
    String date="";
    date+="$year-";
    date+="$month-";
    date+="$day";
    return date;
  }

}