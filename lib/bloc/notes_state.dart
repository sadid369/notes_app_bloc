// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'notes_bloc.dart';

@immutable
abstract class NotesState {}

class NotesInitialState extends NotesState {}

class NotesLoadingSate extends NotesState {}

class NotesLoadedSate extends NotesState {
  final List<Notes> notes;
  NotesLoadedSate({
    required this.notes,
  });
}

class NotesAddedState extends NotesState {
  final bool isNoteCreated;
  NotesAddedState({
    required this.isNoteCreated,
  });
}

class NotesUpdatedState extends NotesState {
  final bool isNoteUpdated;
  NotesUpdatedState({
    required this.isNoteUpdated,
  });
}

class NotesDeletedState extends NotesState {
  final bool isNoteDeleted;
  NotesDeletedState({
    required this.isNoteDeleted,
  });
}
