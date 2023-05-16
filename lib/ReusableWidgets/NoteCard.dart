import 'package:flutter/material.dart';
import 'package:HaniNotes/Models/Date.dart';
import 'package:HaniNotes/Models/Note.dart';

Widget NoteCard(Function()? onTap, Note doc) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.blue[200], borderRadius: BorderRadius.circular(15)),
    padding: const EdgeInsets.all(4),
    margin: const EdgeInsets.all(4),
    child: InkWell(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.all(4),
          margin: const EdgeInsets.all(4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 1,
                  child: Text(doc.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16))),
              Expanded(
                flex: 6,
                child: Text(
                  doc.content,
                  overflow: TextOverflow.visible,
                  maxLines: 6,
                ),
              ),
              const Expanded(flex: 1, child: SizedBox(height: 1)),
              Text(Date.getDate(doc.creationDate).toString()),
            ],
          )),
    ),
  );
}
