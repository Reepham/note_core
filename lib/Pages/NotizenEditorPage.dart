import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:HaniNotes/Models/Note.dart';
import 'package:share_plus/share_plus.dart';
import 'package:HaniNotes/Models/Date.dart';
import 'package:HaniNotes/ReusableWidgets/Menu.dart';
import 'package:HaniNotes/Models/WidgetModels/CustomMenuItem.dart';
import 'package:HaniNotes/db/database_provider.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

class NotizenEditor extends StatefulWidget {
  const NotizenEditor(this.doc, {Key? key}) : super(key: key);
  final Note doc;
  @override
  State<NotizenEditor> createState() => _NotizenEditorState();
}

class _NotizenEditorState extends State<NotizenEditor> {
  final TextEditingController _titleController = TextEditingController();
  late QuillController _quillcontroller;

  DateTime date = DateTime.now();
  List<CustomMenuItem> menuItems = <CustomMenuItem>[];
  @override
  void initState() {
    super.initState();

    menuItems = [
      CustomMenuItem(
        onTap: () => Share.share(_quillcontroller.document.toPlainText(),
            subject: _titleController.text),
        text: 'Teilen',
        icon: Icons.share_outlined,
      ),
      CustomMenuItem(
          onTap: _delete, text: 'Löschen', icon: Icons.delete_outline)
    ];

    _titleController.text = widget.doc.title;
    date = widget.doc.creationDate;
    _quillcontroller = QuillController(
        document: Document.fromJson(jsonDecode(widget.doc.content)),
        selection: const TextSelection.collapsed(offset: 0));
  }

  _delete() {
    DatabaseProvider.db.deleteNote(widget.doc);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        children: [
          Expanded(child: Text(widget.doc.title)),
          Menu.generate(
              context, const Icon(Icons.menu, color: Colors.white), menuItems)
        ],
      )),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            QuillToolbar.basic(
                controller: _quillcontroller,
                multiRowsDisplay: false,
                showSubscript: false,
                showSuperscript: false),
            TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: "Titel"),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Text(
              Date.getDate(date).toString(),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: QuillEditor.basic(
                controller: _quillcontroller,
                readOnly: false, // true for view only mode
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.doc.content =
              jsonEncode(_quillcontroller.document.toDelta().toJson());
          widget.doc.title = _titleController.text;
          DatabaseProvider.db.updateNote(widget.doc);
          Navigator.pop(context);
        },
        tooltip: 'Notiz speichern',
        // backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        // foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        child: const Icon(Icons.save),
      ),
    );
  }
}
