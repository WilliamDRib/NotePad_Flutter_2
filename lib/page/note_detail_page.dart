import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:Notepad/db/notes_database.dart';
import 'package:Notepad/model/note.dart';
import 'package:Notepad/page/edit_note_page.dart';
import 'package:google_sign_in/google_sign_in.dart';

class NoteDetailPage extends StatefulWidget {

  final GoogleSignInAccount user;

  final int noteId;

  const NoteDetailPage({
    Key? key,
    required this.noteId,
    required this.user,
  }) : super(key: key);

  @override
  _NoteDetailPageState createState() => _NoteDetailPageState(user: user);
}

class _NoteDetailPageState extends State<NoteDetailPage> {

  final GoogleSignInAccount user;

  _NoteDetailPageState({
    required this.user,
  });

  late Note note;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNote();
  }

  Future refreshNote() async {
    setState(() => isLoading = true);

    this.note = await NotesDatabase.instance.readNote(widget.noteId, user.email);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [editButton(), deleteButton()],
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.all(12),
                child: ListView(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  children: [
                    Text(
                      note.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      DateFormat.yMd().format(note.createdTime),
                      style: TextStyle(color: Colors.white38),
                    ),
                    SizedBox(height: 8),
                    Text(
                      note.description,
                      style: TextStyle(color: Colors.white70, fontSize: 18),
                    )
                  ],
                ),
              ),
      );

  Widget editButton() => IconButton(
      icon: Icon(Icons.edit_outlined),
      onPressed: () async {
        if (isLoading) return;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddEditNotePage(note: note,user: user,),
        ));

        refreshNote();
      });

  Widget deleteButton() => IconButton(
        icon: Icon(Icons.delete),
        onPressed: () async {
          await NotesDatabase.instance.delete(widget.noteId);

          Navigator.of(context).pop();
        },
      );
}
