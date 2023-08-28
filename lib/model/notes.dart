import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Notes {
  final int? note_id;
  final String user_id;
  final String? title;
  final String? desc;
  final DateTime dateTime;
  Notes({
    this.note_id,
    required this.user_id,
    this.title,
    this.desc,
  }) : this.dateTime = DateTime.now();

  Notes copyWith({
    int? note_id,
    String? user_id,
    String? title,
    String? desc,
    DateTime? dateTime,
  }) {
    return Notes(
      note_id: note_id ?? this.note_id,
      user_id: user_id ?? this.user_id,
      title: title ?? this.title,
      desc: desc ?? this.desc,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'note_id': note_id,
      'user_id': user_id,
      'title': title,
      'desc': desc,
      'dateTime': dateTime.millisecondsSinceEpoch,
    };
  }

  factory Notes.fromMap(Map<String, dynamic> map) {
    return Notes(
      note_id: map['note_id'] != null ? map['note_id'] as int : null,
      user_id: map['user_id'] as String,
      title: map['title'] != null ? map['title'] as String : null,
      desc: map['desc'] != null ? map['desc'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Notes.fromJson(String source) =>
      Notes.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Notes(note_id: $note_id, user_id: $user_id, title: $title, desc: $desc, dateTime: $dateTime)';
  }

  @override
  bool operator ==(covariant Notes other) {
    if (identical(this, other)) return true;

    return other.note_id == note_id &&
        other.user_id == user_id &&
        other.title == title &&
        other.desc == desc &&
        other.dateTime == dateTime;
  }

  @override
  int get hashCode {
    return note_id.hashCode ^
        user_id.hashCode ^
        title.hashCode ^
        desc.hashCode ^
        dateTime.hashCode;
  }
}
