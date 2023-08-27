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
  static final NOTE_COLOUM_USER_ID = "user_id";
  static final NOTE_COLOUM_TITLE = "title";
  static final NOTE_COLOUM_DESC = "desc";
  static final USER_TABLE = "user";
  static final USER_COLOUM_ID = "user_id";
  static final USER_COLOUM_NAME = "name";
  static final USER_COLOUM_EMAIL = "email";
  static final USER_COLOUM_PHONE = "phone";
  static final USER_COLOUM_PASSWORD = "password";

  var sqlCreateTable =
      "Create table $NOTE_TABLE ($NOTE_COLOUM_ID integer PRIMARY KEY autoincrement, $NOTE_COLOUM_TITLE text, $NOTE_COLOUM_DESC text, $NOTE_COLOUM_USER_ID text unique )";

  Future<Database> getDB() async {
    if (_database != null) {
      return _database!;
    } else {
      return await initDB();
    }
  }

  Future<bool> addNotes({required Notes notes}) async {
    var db = await getDB();
    var rowsEffected = await db.insert(NOTE_TABLE, notes.toMap());

    if (rowsEffected > 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<Notes>> fetchAllNotes({required String user_id}) async {
    List<Notes>? notes;

    var db = await getDB();
    var notesList = await db.query(NOTE_TABLE,
        where: "$NOTE_COLOUM_USER_ID = ?", whereArgs: ["$user_id"]);

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
  //  Future<bool> createUser({required Notes notes}) async {
  //   var db = await getDB();
  //   if()
  //   var rowsEffected = await db.insert(NOTE_TABLE, notes.toMap());

  //   if (rowsEffected > 0) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
}
