import 'package:flutter/material.dart';
import 'package:HaniNotes/Models/Note.dart';
import 'package:HaniNotes/Models/Date.dart';
import 'package:HaniNotes/db/database_provider.dart';

class NotizenNew extends StatefulWidget {
  const NotizenNew({Key? key}) : super(key: key);
  @override
  State<NotizenNew> createState() => _NotizenNewState();
}

class _NotizenNewState extends State<NotizenNew> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _mainController = TextEditingController();
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Neue Notiz")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: "Titel"),
            ),
            const SizedBox(height: 8),
            Text(Date.getDate(date).toString()),
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
          DatabaseProvider.db.addNewNote(Note(
              title: _titleController.text,
              creationDate: date,
              content: _mainController.text));

          Navigator.pop(context);
        },
        tooltip: 'Notiz speichern',
        child: const Icon(Icons.save),
      ),
    );
  }
}
