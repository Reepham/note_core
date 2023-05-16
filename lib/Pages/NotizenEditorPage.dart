import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:HaniNotes/Models/Note.dart';
import 'package:share_plus/share_plus.dart';
import 'package:HaniNotes/Models/Date.dart';
import 'package:HaniNotes/ReusableWidgets/Menu.dart';
import 'package:HaniNotes/Models/WidgetModels/CustomMenuItem.dart';
import 'package:HaniNotes/db/database_provider.dart';

class NotizenEditor extends StatefulWidget {
  NotizenEditor(this.doc, {Key? key}) : super(key: key);
  Note doc;
  @override
  State<NotizenEditor> createState() => _NotizenEditorState();
}

class _NotizenEditorState extends State<NotizenEditor> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _mainController = TextEditingController();
  DateTime date = DateTime.now();
  List<CustomMenuItem> menuItems = <CustomMenuItem>[];
  @override
  void initState() {
    super.initState();
    menuItems = [
      CustomMenuItem(
        onTap: () =>
            Share.share(_mainController.text, subject: _titleController.text),
        text: 'Teilen',
        icon: Icons.share_outlined,
      ),
      CustomMenuItem(
          onTap: _delete, text: 'Löschen', icon: Icons.delete_outline)
    ];
    _titleController.text = widget.doc.title;
    _mainController.text = widget.doc.content;
    date = widget.doc.creationDate;
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
                child: TextField(
              controller: _mainController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: "Notiz"),
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.doc.content = _mainController.text;
          widget.doc.title = _titleController.text;
          DatabaseProvider.db.updateNote(widget.doc);
          Navigator.pop(context);
        },
        tooltip: 'Notiz speichern',
        child: const Icon(Icons.save),
      ),
    );
  }
}
