import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:notes_app_bloc/model/notes.dart';
import 'package:notes_app_bloc/model/user_model.dart';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  AppDatabase._();
  static final AppDatabase db = AppDatabase._();
  Database? _database;

  static const NOTE_TABLE = "note";
  static const NOTE_COLOUM_ID = "note_id";
  static const NOTE_COLOUM_USER_ID = "user_id";
  static const NOTE_COLOUM_TITLE = "title";
  static const NOTE_COLOUM_DESC = "desc";
  static const NOTE_COLOUM_DATE = "dateTime";
  static const USER_TABLE = "user";
  static const USER_COLOUM_ID = "user_id";
  static const USER_COLOUM_NAME = "name";
  static const USER_COLOUM_EMAIL = "email";
  static const USER_COLOUM_PHONE = "phone";
  static const USER_COLOUM_PASSWORD = "password";

  var sqlCreateTableNotes =
      "Create table $NOTE_TABLE ($NOTE_COLOUM_ID integer PRIMARY KEY autoincrement, $NOTE_COLOUM_TITLE text, $NOTE_COLOUM_DESC text, $NOTE_COLOUM_USER_ID text unique,$NOTE_COLOUM_DATE INTEGER )";
  var sqlCreateTableUser =
      "Create table $USER_TABLE  ($USER_COLOUM_ID integer PRIMARY KEY autoincrement, $USER_COLOUM_NAME text, $USER_COLOUM_EMAIL text unique , $USER_COLOUM_PHONE text unique , $USER_COLOUM_PASSWORD text )";

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
      onCreate: (db, version) async {
        await db.execute(sqlCreateTableNotes);
        await db.execute(sqlCreateTableUser);
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

  Future<bool> signUpUser({required UserModel user}) async {
    var db = await getDB();
    var isUserExists = await db.query(USER_TABLE,
        where: " $USER_COLOUM_EMAIL = ? or $USER_COLOUM_PHONE = ?",
        whereArgs: [user.email, user.phone]);
    if (isUserExists.isNotEmpty) {
      return false;
    }
    var rowsEffected = await db.insert(USER_TABLE, user.toMap());

    if (rowsEffected > 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> loginUser(
      {required String email, required String password}) async {
    var db = await getDB();
    var user = await db.query(USER_TABLE,
        where: "$USER_COLOUM_EMAIL = ? and $USER_COLOUM_PASSWORD = ?",
        whereArgs: [email, password]);
    if (user.isEmpty) {
      return false;
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("user_id", (user[0][USER_COLOUM_ID]).toString());
    return true;
  }
}
