 
import 'package:daily_tasks1/db/db_crud.dart';
import 'package:daily_tasks1/model/day_tasks.dart';
import 'package:daily_tasks1/model/task_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TasksCon extends GetxController{
  DateTime date =DateTime.now() ;


  db_crud db = db_crud();

  Future<List<TaskModel>>? buildTasks ;
  Future<List< TaskModel>>read() async {
    final db1 = await db.initializeDB();

    final List<Map<String, dynamic>> queryResult = await db1.rawQuery('SELECT * FROM "Tasks" ORDER BY id DESC');
    return queryResult.map((e) =>TaskModel.fromMap(e)).toList();

  }
  Future<List< TaskModel>>readTasks( int dayId) async {
    final db1 = await db.initializeDB();

    final List<Map<String, dynamic>> queryResult = await db1.rawQuery('SELECT * FROM "Tasks" WHERE  dayID LIKE $dayId ORDER BY id DESC');
    return queryResult.map((e) =>TaskModel.fromMap(e)).toList();

  }
  Future<List< TaskModel>>readTasksOnMonth( int y, int m) async {
    final db1 = await db.initializeDB();

    final List<Map<String, dynamic>> queryResult = await db1.rawQuery('SELECT * FROM "Tasks" WHERE  y LIKE $y AND m LIKE $m ORDER BY id DESC');
    return queryResult.map((e) =>TaskModel.fromMap(e)).toList();

  }
  Future<void> updateTasks(  TaskModel taskModel) async {
    // Get a reference to the database.
    final db1 = await db.initializeDB();

    // Update the given Dog.
    await db1.update(
      'Tasks',
      taskModel.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [taskModel.id],
    );
  }

  Future<void> delete(String NameDB,int id) async {
    // Get a reference to the database.
    final db1 = await db.initializeDB();

    // Remove the Dog from the database.
    await db1.delete(
      NameDB,
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

      changeBoolValue(int i){
        TaskModel upData;
        buildTasks?.then((value) {
          value[i].is_done==1?couTaskDone-=1 :couTaskDone+=1;
          value[i].is_done ==1?upData= value[i]=TaskModel(value[i].id, value[i].title, 0, value[i].y, value[i].m, value[i].d, value[i].h, value[i].mi, value[i].dayName, value[i].dayID):
          upData= value[i]=TaskModel(value[i].id, value[i].title, 1, value[i].y, value[i].m, value[i].d, value[i].h, value[i].mi, value[i].dayName, value[i].dayID);
          updateTasks(upData);



          update();
        });
}

  insertTask(int newid,String title,int dayid ,){
    String dayName = DateFormat('EEEE').format(date);
    db.insertTasks(
        TaskModel(newid, title, 0, date.year, date.month, date.day, date.hour, date.microsecond, dayName, dayid)
    );
    buildTasks!.then(
            (value) =>
                value.insert(
                    0,
                    TaskModel(newid, title, 0, date.year, date.month, date.day, date.hour, date.microsecond, dayName, dayid)

                )
    );
    print(TaskModel(newid, title, 0, date.year, date.month, date.day, date.hour, date.microsecond, dayName, dayid));

    update();
  }


deleteItme(int id ,TaskModel index ){
  String dayName = DateFormat('EEEE').format(date);

  delete(
      'Tasks',id);
 buildTasks!.then((value) => value.remove(index));
 update();
}






int id=0;
int  couTaskDone=0;
int  couTask=0;

  int newID(int i) {

    read().asStream().listen((event) {
      id = event.first.id;
      print('id$id');
    });
    return id + 1;
  }
   count(int y,int m ) {
     couTaskDone=0;
     couTask=0;
   readTasksOnMonth(y, m).asStream().listen((event) {
     couTask=event.length;
     print('couTaskDone$couTaskDone');
     print('couTaskDone$couTaskDone');

     for (int i=0;i<event.length;i++){


       if(event[i].is_done==1){
      couTaskDone+=1;
      print('y= $y');
      print('m= $m');

      print('title ${event[i].title}');
      print('dayID ${event[i].dayID}');
      print('couTaskDone$couTaskDone');

       }
     }
    });
   update();
  }
@override
  void onInit() {
  count(date.year,date.month);
  super.onInit();
  }
}

