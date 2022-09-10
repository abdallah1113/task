import 'package:daily_tasks1/model/day_tasks.dart';
import 'package:daily_tasks1/model/task_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class db_crud {


  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'DT_database.db'),
      onCreate: (database, version) async {
        await database.execute(
          'CREATE TABLE Tasks(id INTEGER PRIMARY KEY, title TEXT,dayName TEXT,y INTEGER,m INTEGER,d INTEGER,is_done INTEGER ,h INTEGER,mi INTEGER,dayID INTEGER)',

        );
        await database.execute(
          'CREATE TABLE dailyTasks(id INTEGER PRIMARY KEY, title TEXT,subtitle TEXT,dayName TEXT,y INTEGER,m INTEGER,d INTEGER,h INTEGER,mi INTEGER)',

        );
        await database.execute(
          'CREATE TABLE monthTasks(id INTEGER PRIMARY KEY, title TEXT, taskType TEXT, y INTEGER,m INTEGER)',

        );

      },
      version: 2,
    );
  }

  // Define a function that inserts dogs into the database
  Future<void> insert(String NameDB, DailyTasksModel DailyTasksModel) async {
    // Get a reference to the database.
    final db = await initializeDB();

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'dailyTasks',
      DailyTasksModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  Future<void> insertTasks(TaskModel  taskModel) async {
    // Get a reference to the database.
    final db = await initializeDB();

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'Tasks',
      taskModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<DailyTasksModel>> reads(String NameDB) async {
    // Get a reference to the database.
    final db = await initializeDB();

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> queryResult = await db.query('dailyTasks');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return queryResult.map((e) =>  DailyTasksModel.fromMap(e)).toList();
  }
  Future<List< TaskModel>> readsTasks() async {
    // Get a reference to the database.
    final db = await initializeDB();

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> queryResult = await db.query('Tasks');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return queryResult.map((e) =>TaskModel.fromMap(e)).toList();
  }





  Future<void> update( String NameDB,DailyTasksModel DailyTasksModel) async {
    // Get a reference to the database.
    final db = await initializeDB();

    // Update the given Dog.
    await db.update(
      NameDB,
      DailyTasksModel.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a wshereArg to prevent SQL injection.
      whereArgs: [DailyTasksModel.id],
    );
  }
  Future<void> updateTasks(  TaskModel taskModel) async {
    // Get a reference to the database.
    final db = await initializeDB();

    // Update the given Dog.
    await db.update(
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
    final db = await initializeDB();

    // Remove the Dog from the database.
    await db.delete(
      NameDB,
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }
}