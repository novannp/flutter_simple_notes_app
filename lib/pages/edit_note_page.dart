import 'package:flutter/material.dart';
import 'package:notes_app/db/database_provider.dart';
import 'package:notes_app/pages/main_page.dart';

import '../models/note.dart';

// ignore: must_be_immutable
class EditNotePage extends StatefulWidget {
  NoteModel note;
  EditNotePage({Key? key, required this.note}) : super(key: key);

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  var descController = TextEditingController();
  var titleController = TextEditingController();
  late String title;
  late String body;
  late DateTime date;

  @override
  void initState() {
    titleController.text = widget.note.title.toString();
    descController.text = widget.note.body.toString();
    super.initState();
  }

  editNote(NoteModel note) async {
    await DatabaseProvider.db.updateNote(note);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          icon: const Icon(Icons.save),
          label: Text('save notes'.toUpperCase()),
          onPressed: () {
            setState(() {
              title = titleController.text;
              body = descController.text;
              date = DateTime.now();
            });

            NoteModel note = NoteModel(
              id: widget.note.id,
              title: titleController.text,
              body: descController.text,
              creationDate: date,
            );
            editNote(note);
            // ignore: use_build_context_synchronously

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) {
                return const MainPage();
              }),
              (route) => false,
            );
          }),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              DatabaseProvider.db.deleteNote(widget.note.id!);
              Navigator.pop(context);
            },
            icon: const Icon(Icons.delete_forever_outlined),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 8, right: 24, left: 24),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: widget.note.title,
                  border: InputBorder.none,
                ),
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: descController,
                keyboardType: TextInputType.multiline,
                maxLines: 100,
                decoration: InputDecoration(
                  hintText: widget.note.body,
                  border: InputBorder.none,
                ),
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
