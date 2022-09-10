import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import '../db/db_crud.dart';
import '../model/month_model.dart';

class MonthController extends GetxController{
  DateTime date =DateTime.now();

  db_crud db = db_crud();

  Future<List<MonthModel>>? bulidData;
  Future<void> insertToDB( MonthModel monthModel) async {
    final db1 = await db.initializeDB();
    await db1.insert(
      'monthTasks',
      monthModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  insertData(int id, String title, String taskType,) {
    insertToDB(
        MonthModel( id, title, taskType, date.year, date.month));
    bulidData?.then((v) => v.insert(0, MonthModel(id, title, taskType,date.year, date.month, )));
    update();
  }


  Future<List<MonthModel>> readOneMonth() async {
    await db.initializeDB();

    final db1 = await db.initializeDB();

    final List<Map<String, dynamic>> queryResult = await db1
        .rawQuery('SELECT * FROM "monthTasks" WHERE  m LIKE ${date.month} AND y LIKE ${date.year} ORDER BY id DESC');
    return queryResult.map((e) => MonthModel.fromMap(e)).toList();
  }
  Future<List<MonthModel>> reads() async {
    final db1 = await db.initializeDB();

    final List<Map<String, dynamic>> queryResult =
    await db1.query('monthTasks');

    return queryResult.map((e) => MonthModel.fromMap(e)).toList();
  }
  int id = 0;

  int newID() {
  reads().asStream().listen((event) {
      id = event.last.id;
    });
    return id + 1;
  }
  List<String> op=[];

   addOp()  {
    op=[];

     print('object');

    readOneMonth().asStream().listen((event) {

      for(int i=0; i<event.length ;i++){
        print('i=$i');

      op.add(event[i].title);

      }

  });
  }
  int cou=0;
  count() {
    cou = 0;
    print('cou${cou}');
    readOneMonth().asStream().listen((event) {
      cou = event.length;
      print('aa${cou}');
      update();
    });
    update();
    return cou;
  }

@override
  void onInit() {
     bulidData=readOneMonth();
     addOp();
    super.onInit();
  }
}