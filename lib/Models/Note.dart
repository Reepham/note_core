import 'package:HaniNotes/Models/Date.dart';

class Note {
  int? id;
  String title;
  String content;
  DateTime creationDate;

  Note({
    this.id,
    this.title = "Notiz",
    this.content = "Text",
    required this.creationDate
  });

  @override toString() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'creationDate:': Date.getDate(creationDate).toString()
    }.toString();
  }

  Map<String,dynamic> toMap(){
    return({
      'id': id,
      'title': title,
      'content': content,
      'creationDate': creationDate.toIso8601String(),
    });
  }
}