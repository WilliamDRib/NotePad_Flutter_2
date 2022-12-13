final String tableNotes = 'notes';

class NoteFields {
  static final List<String> values = [
    /// Add all fields
    id, number, title, description, time, user
  ];

  static final String id = '_id';
  static final String number = 'number';
  static final String title = 'title';
  static final String description = 'description';
  static final String time = 'time';
  static final String user = 'user';
}

class Note {
  final int? id;
  final int number;
  final String title;
  final String description;
  final DateTime createdTime;
  final String user;

  const Note({
    this.id,
    required this.number,
    required this.title,
    required this.description,
    required this.createdTime,
    required this.user,
  });

  Note copy({
    int? id,
    int? number,
    String? title,
    String? description,
    DateTime? createdTime,
    String? user,

  }) =>
      Note(
        id: id ?? this.id,
        number: number ?? this.number,
        title: title ?? this.title,
        description: description ?? this.description,
        createdTime: createdTime ?? this.createdTime,
        user: user ?? this.user,
      );

  static Note fromJson(Map<String, Object?> json) => Note(
        id: json[NoteFields.id] as int?,
        number: json[NoteFields.number] as int,
        title: json[NoteFields.title] as String,
        description: json[NoteFields.description] as String,
        createdTime: DateTime.parse(json[NoteFields.time] as String),
        user: json[NoteFields.user] as String,
      );

  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.title: title,
        NoteFields.number: number,
        NoteFields.description: description,
        NoteFields.time: createdTime.toIso8601String(),
        NoteFields.user: user,
      };
}
