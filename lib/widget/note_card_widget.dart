import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:Notepad/model/note.dart';

final colors = [
  Colors.red.shade200,
  Colors.deepOrange.shade200,
  Colors.orange.shade300,
  Colors.lightGreen.shade300,
  Colors.green.shade300,
  Colors.teal.shade200,
  Colors.purple.shade200,
  Colors.deepPurple.shade300,
  Colors.blueGrey.shade300,
  Colors.grey,
  Colors.indigo.shade300,
  Colors.brown.shade300,
];

class NoteCardWidget extends StatelessWidget {
  NoteCardWidget({
    Key? key,
    required this.note,
    required this.index,
  }) : super(key: key);

  final Note note;
  final int index;

  @override
  Widget build(BuildContext context) {
    /// Pick colors from the accent colors based on index
    final color = colors[index % colors.length];
    final time = DateFormat.yMd().format(note.createdTime);

    return Card(
      color: color,
      child: Container(
        constraints: BoxConstraints(minHeight: 100),
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              time,
              style: TextStyle(color: Colors.grey.shade700),
            ),
            SizedBox(height: 4),
            Text(
              note.title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
