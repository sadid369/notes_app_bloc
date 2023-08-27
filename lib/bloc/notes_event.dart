// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'notes_bloc.dart';

@immutable
abstract class NotesEvent {}

class NotesInitialEvent extends NotesEvent {
  final int user_id;
  NotesInitialEvent({
    required this.user_id,
  });
}

class NotesAddEvent extends NotesEvent {
  Notes notes;
  NotesAddEvent({
    required this.notes,
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
  final String user_id;
  NotesDeleteEvent({
    required this.id,
    required this.user_id,
  });
}
