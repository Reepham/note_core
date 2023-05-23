import 'package:flutter/material.dart';
import 'package:HaniNotes/Models/Note.dart';
import 'package:HaniNotes/Pages/NotizenEditorPage.dart';
import 'package:HaniNotes/Pages/NotizenNewPage.dart';
import 'package:HaniNotes/ReusableWidgets/NoteCard.dart';
import 'package:HaniNotes/db/database_provider.dart';
import 'package:HaniNotes/ReusableWidgets/HomeBottomBar.dart';

class NotizenPage extends StatefulWidget {
  const NotizenPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<NotizenPage> createState() => _NotizenPageState();
}

class _NotizenPageState extends State<NotizenPage> {
  @override
  void initState() {
    super.initState();
    _data = getNotes();
  }

  late Future<List<Note>> _data;

  Future<List<Note>> getNotes() async {
    return await DatabaseProvider.db.getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List>(
        future: _data,
        initialData: const <Note>[],
        builder: (context, snapshot) {
          return snapshot.hasData
              ? GridView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Note note = snapshot.data![index];
                    return NoteCard(
                        onTap: () {
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          NotizenEditor(note)))
                              .then((_) => setState(() {
                                    _data = getNotes();
                                  }));
                        },
                        doc: note);
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4),
                )
              : const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const NotizenNew()))
              .then((_) => setState(() {
                    _data = getNotes();
                  }));
        },
        tooltip: 'Neue Notiz',
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const HomeBottomBar(),
    );
  }
}
