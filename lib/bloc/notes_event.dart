// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'notes_bloc.dart';

@immutable
abstract class NotesEvent {}

class NotesInitialEvent extends NotesEvent {}

class NotesAddEvent extends NotesEvent {
  final String title;
  final String desc;
  NotesAddEvent({
    required this.title,
    required this.desc,
  });
}

class NotesUpdateEvent extends NotesEvent {
  final Notes notes;

  NotesUpdateEvent({
    required this.notes,
  });
}

class NotesDeleteEvent extends NotesEvent {
  final int id;
  NotesDeleteEvent({
    required this.id,
  });
}
