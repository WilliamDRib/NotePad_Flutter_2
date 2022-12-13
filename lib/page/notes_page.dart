import 'package:Notepad/api/google_signin_api.dart';
import 'package:Notepad/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:Notepad/db/notes_database.dart';
import 'package:Notepad/model/note.dart';
import 'package:Notepad/page/about.dart';
import 'package:Notepad/page/edit_note_page.dart';
import 'package:Notepad/page/note_detail_page.dart';
import 'package:Notepad/widget/note_card_widget.dart';
import 'package:google_sign_in/google_sign_in.dart';

class NotesPage extends StatefulWidget {
  final GoogleSignInAccount user;

  NotesPage({
    Key ? key,
    required this.user,
  }) : super(key: key);

  @override
  _NotesPageState createState() => _NotesPageState(user: user);
}

class _NotesPageState extends State<NotesPage> {

  final GoogleSignInAccount user;

  _NotesPageState({
    required this.user,
  });

  late List<Note> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  @override
  void dispose() {
    NotesDatabase.instance.close();

    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    this.notes = await NotesDatabase.instance.readAllNotes(user.email); 

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Anotações',
            style: TextStyle(fontSize: 24),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.info_sharp),
              onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => About()),
                );
              },
            ),
            TextButton(
              child: Text(
                      'Logout',
                      style: TextStyle(color: Colors.white),
                    ),
              onPressed: () async {
                await GoogleSignInApi.logout();

                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ));
              },
            ),
          ],
        ),
        body: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : notes.isEmpty
                  ? Text(
                      'Sem anotações',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    )
                  : buildNotes(),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(Icons.add),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddEditNotePage(user: user)),
            );

            refreshNotes();
          },
        ),
      );

  Widget buildNotes() => StaggeredGridView.countBuilder(
        padding: EdgeInsets.all(8),
        itemCount: notes.length,
        staggeredTileBuilder: (index) => StaggeredTile.fit(2),
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final note = notes[index];

          return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NoteDetailPage(noteId: note.id!,user: user,),
              ));
              
              refreshNotes();
            },
            child: NoteCardWidget(note: note, index: index),
          );
        },
      );
}
