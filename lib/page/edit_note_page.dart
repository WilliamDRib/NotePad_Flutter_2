import 'package:flutter/material.dart';
import 'package:Notepad/db/notes_database.dart';
import 'package:Notepad/model/note.dart';
import 'package:Notepad/widget/note_form_widget.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AddEditNotePage extends StatefulWidget {
  final Note? note;
  final GoogleSignInAccount user;


  const AddEditNotePage({
    Key? key,
    this.note,
    required this.user,
  }) : super(key: key);
  @override
  _AddEditNotePageState createState() => _AddEditNotePageState(user: user);
}

class _AddEditNotePageState extends State<AddEditNotePage> {

  final GoogleSignInAccount user;

  _AddEditNotePageState({
    required this.user,
  });


  final _formKey = GlobalKey<FormState>();
  late int number;
  late String title;
  late String description;
  late String userEmail = user.email;

  @override
  void initState() {
    super.initState();

    number = widget.note?.number ?? 0;
    title = widget.note?.title ?? '';
    description = widget.note?.description ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [buildButton()],
        ),
        body: Form(
          key: _formKey,
          child: NoteFormWidget(
            number: number,
            title: title,
            description: description,
            onChangedNumber: (number) => setState(() => this.number = number),
            onChangedTitle: (title) => setState(() => this.title = title),
            onChangedDescription: (description) =>
                setState(() => this.description = description),
          ),
        ),
      );

  Widget buildButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        onPressed: addOrUpdateNote,
        child: Text('Salvar'),
      ),
    );
  }

  void addOrUpdateNote() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.note != null;

      if (isUpdating) {
        await updateNote();
      } else {
        await addNote();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateNote() async {
    final note = widget.note!.copy(
      number: number,
      title: title,
      description: description,
    );

    await NotesDatabase.instance.update(note);
  }

  Future addNote() async {

  print(userEmail);

    final note = Note(
      number: number,
      title: title,
      description: description,
      createdTime: DateTime.now(),
      user: userEmail,
    );

    await NotesDatabase.instance.create(note);
  }
}
