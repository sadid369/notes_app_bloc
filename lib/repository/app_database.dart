import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:notes_app_bloc/model/notes.dart';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  AppDatabase._();
  static final AppDatabase db = AppDatabase._();
  Database? _database;

  static final NOTE_TABLE = "note";
  static final NOTE_COLOUM_ID = "note_id";
  static final NOTE_COLOUM_TITLE = "title";
  static final NOTE_COLOUM_DESC = "desc";
  var sqlCreateTable =
      "Create table $NOTE_TABLE ($NOTE_COLOUM_ID integer PRIMARY KEY autoincrement, $NOTE_COLOUM_TITLE text, $NOTE_COLOUM_DESC text)";

  Future<Database> getDB() async {
    if (_database != null) {
      return _database!;
    } else {
      return await initDB();
    }
  }

  Future<bool> addNotes({required String title, required String desc}) async {
    var db = await getDB();
    var rowsEffected =
        await db.insert(NOTE_TABLE, Notes(title: title, desc: desc).toMap());

    if (rowsEffected > 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<Notes>> fetchAllNotes() async {
    List<Notes>? notes;

    var db = await getDB();
    var notesList = await db.query(NOTE_TABLE);

    notes = notesList.map((e) => Notes.fromMap(e)).toList();
    return notes;
  }

  Future<Database> initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    var dbPath = join(documentDirectory.path, "noteDB.db");
    return openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        db.execute(sqlCreateTable);
      },
    );
  }

  Future<bool> updateNote(Notes note) async {
    print(note.note_id);
    var db = await getDB();
    var count = await db.update(
      NOTE_TABLE,
      note.toMap(),
      where: "$NOTE_COLOUM_ID =${note.note_id}",
    );
    return count > 0;
  }

  Future<bool> deleteNote(int id) async {
    var db = await getDB();
    var count = await db
        .delete(NOTE_TABLE, where: "$NOTE_COLOUM_ID = ?", whereArgs: ["$id"]);
    return count > 0;
  }
}
