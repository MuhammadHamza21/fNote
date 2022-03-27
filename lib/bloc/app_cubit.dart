import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  bool isEmpty = true;
  List<Map> notes = [];
  int currentIndex = 0;
  Database? database;
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  //change currentIndex
  void changeCurrentIndex(int value) {
    currentIndex = value;
    emit(ChangeCurrentIndex());
  }

  //create and open database
  void createDatabase() async {
    openDatabase('note.db', version: 1, onCreate: (db, version) {
      print('database created');
      db
          .execute(
              'CREATE TABLE note(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, body TEXT, date TEXT)')
          .then((value) {
        print('table created');
      });
    }, onOpen: (db) {
      getDataFromDatabase(db);
      print('database opened');
    }).then((value) {
      database = value;
      emit(CreateDatabaseState());
    });
  }

  //insert record into database
  void insertRecordToDatabase({
    required String title,
    required String body,
    required String date,
  }) async {
    await database!.transaction(
      (txn) async {
        txn
            .rawInsert(
          'insert into note(title, body, date) values("$title","$body","$date")',
        )
            .then(
          (value) {
            emit(InsertRecordToDatabase());
            getDataFromDatabase(database!);
            print('record inserted succesfully');
          },
        ).catchError((error) {
          print('Error while inserting new record : $error \n\n\n');
        });
      },
    );
  }

  //get data from database
  void getDataFromDatabase(Database database) async {
    notes = [];
    database.rawQuery('select * from note').then((value) {
      emit(GetDataFromDatabase());
      notes = value;
      //print(notes);
    }).catchError((error) {
      print('Error while selecting record : $error \n\n\n');
    });
  }

  //delete record from database
  void deleteRecordFromDatabase(int id) {
    print(id);
    database!.rawDelete('delete from note where id = ?', [id]).then((value) {
      emit(DeleteRecordFromDatabase());
      getDataFromDatabase(database!);
    }); 
  }

  //update record from database
  void updateRecordFromDatabase({
    required String title,
    required String body,
    required String date,
    required int id,
  }) {
    database!.rawUpdate(
      'update note set title = ?, body = ?, date = ? where id = ?',
      ['$title', '$body', '$date', id],
    ).then((value) {
      emit(UpdateRecordFromDatabase());
      getDataFromDatabase(database!);
    });
  }
}
