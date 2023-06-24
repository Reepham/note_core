import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:HaniNotes/Models/Date.dart';
import 'package:HaniNotes/Models/Note.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

class NoteCard extends StatelessWidget {
  NoteCard({Key? key, required this.onTap, required this.doc})
      : super(key: key);

  final Note doc;
  final Function()? onTap;
  late final QuillController quillcontroller = QuillController(
    document: Document.fromJson(jsonDecode(doc.content)),
    selection: const TextSelection.collapsed(offset: 0),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(15)),
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
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ))),
                Expanded(
                  flex: 6,
                  child: Text(quillcontroller.document.toPlainText(),
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      )),
                ),
                const Expanded(flex: 1, child: SizedBox(height: 1)),
                Text(
                  Date.getDate(doc.creationDate).toString(),
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer),
                ),
              ],
            )),
      ),
    );
  }
}
