import 'package:flutter/material.dart';

class NoteFormWidget extends StatelessWidget {
  final int? number;
  final String? title;
  final String? description;
  final ValueChanged<int> onChangedNumber;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;

  const NoteFormWidget({
    Key? key,
    this.number = 0,
    this.title = '',
    this.description = '',
    required this.onChangedNumber,
    required this.onChangedTitle,
    required this.onChangedDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildTitle(),
              SizedBox(height: 8),
              buildDescription(),
              SizedBox(height: 16),
            ],
          ),
        ),
      );

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: title,
        style: TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Titulo',
          hintStyle: TextStyle(color: Colors.white70),
        ),
        validator: (title) => title != null && title.isEmpty
            ? 'O titulo não pode ser vazio'
            : null,
        onChanged: onChangedTitle,
      );

  Widget buildDescription() => TextFormField(
        maxLines: 6,
        initialValue: description,
        style: TextStyle(color: Colors.white60, fontSize: 18),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Escreva algo...',
          hintStyle: TextStyle(color: Colors.white60),
        ),
        validator: (title) => title != null && title.isEmpty
            ? 'A descrição não pode ser vazia'
            : null,
        onChanged: onChangedDescription,
      );
}
