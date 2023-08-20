import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Notes {
  final int? note_id;
  final String? title;
  final String? desc;
  final DateTime dateTime;

  Notes({
    this.note_id,
    this.title,
    this.desc,
  }) : this.dateTime = DateTime.now();

  Notes copyWith({
    int? note_id,
    String? title,
    String? desc,
  }) {
    return Notes(
      note_id: note_id ?? this.note_id,
      title: title ?? this.title,
      desc: desc ?? this.desc,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'note_id': note_id,
      'title': title,
      'desc': desc,
    };
  }

  factory Notes.fromMap(Map<String, dynamic> map) {
    return Notes(
      note_id: map['note_id'] != null ? map['note_id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      desc: map['desc'] != null ? map['desc'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Notes.fromJson(String source) =>
      Notes.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Notes(note_id: $note_id, title: $title, desc: $desc)';

  @override
  bool operator ==(covariant Notes other) {
    if (identical(this, other)) return true;

    return other.note_id == note_id &&
        other.title == title &&
        other.desc == desc;
  }

  @override
  int get hashCode => note_id.hashCode ^ title.hashCode ^ desc.hashCode;
}
