import 'package:daily_tasks1/controller/tasks_controller.dart';
import 'package:daily_tasks1/db/db_crud.dart';
import 'package:daily_tasks1/model/day_tasks.dart';
import 'package:daily_tasks1/model/task_model.dart';
import 'package:daily_tasks1/ui/month_task.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import '../colors.dart';
import '../ui/add_daily_tasks.dart';
import 'month_controller.dart';

class DailyTasksCon extends GetxController {

  db_crud db = db_crud();
  DateTime date = DateTime.now();
  Future<List<DailyTasksModel>>? bulidData;

  Future<void> insertToDB(DailyTasksModel DailyTasksModel) async {
    final db1 = await db.initializeDB();

    await db1.insert(
      'dailyTasks',
      DailyTasksModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  insertData(int id, String title,String sub) {
    String dayName = DateFormat('EEEE').format(date);
    insertToDB(DailyTasksModel(id, title,sub, date.year, date.month, date.day,
        date.hour, date.millisecond, dayName));
    bulidData?.then((v) => v.insert(
        0,
        DailyTasksModel(id, title,sub, date.year, date.month, date.day, date.hour,
            date.millisecond, dayName)));
    update();
  }

  Future<List<TaskModel>> readsTasks() async {
    final db1 = await db.initializeDB();

    final List<Map<String, dynamic>> queryResult = await db1.query('Tasks');

    return queryResult.map((e) => TaskModel.fromMap(e)).toList();
  }

  Future<List<DailyTasksModel>> readOneMonth() async {
    await db.initializeDB();

    final db1 = await db.initializeDB();

    final List<Map<String, dynamic>> queryResult = await db1.rawQuery(
        'SELECT * FROM "dailyTasks" WHERE  y LIKE ${date.year} AND m LIKE ${date.month} ORDER BY id DESC');
    cou = queryResult.length.obs;
    print('con com :$cou');
    return queryResult.map((e) => DailyTasksModel.fromMap(e)).toList();
  }

  Future<List<DailyTasksModel>> reads() async {
    final db1 = await db.initializeDB();

    final List<Map<String, dynamic>> queryResult =
        await db1.query('dailyTasks');

    return queryResult.map((e) => DailyTasksModel.fromMap(e)).toList();
  }

  int id = 0;

  int newID() {
    reads().asStream().listen((event) {
      id = event.last.id;
    });
    print(id);

    return id + 1;
  }

  deletAllTasksForDaily(int index) async {
    final db1 = await db.initializeDB();

    await db1.rawQuery('DELETE FROM "Tasks" WHERE dayID = $index ');
  }

  RxInt cou = 0.obs;

  RxInt count() {
    cou = 0.obs;
    print('cou${cou}');
    readOneMonth().asStream().listen((event) {
      cou = event.length.obs;
      print('aa${cou}');
      update();
    });
    update();
    return cou;
  }
  MonthController monthController=Get.put(MonthController());

  Widget test(BuildContext context) {

        return DateTime.now().year == date.year &&
            DateTime.now().month == date.month
        ? FloatingActionButton(
          backgroundColor: mainColor,
            onPressed: () async {
              update();
            await  monthController.count();
              newID();
              monthController.cou==0 ?  showDialog(
                context: context,
                builder: (BuildContext context) {
                  return alert(context);
                },

              ) :
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) => SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: AddTaskScreen(),
                  ),
                ),
              );

              update();
            },
            child: const Icon(Icons.add),
          )
        : GetBuilder<TasksCon>(
            init: TasksCon(),
            builder: (c) {
              return FloatingActionButton(
                  child: Text('الحالي'),
                  onPressed: () {
                    c.count(DateTime.now().year, DateTime.now().month);
                    c.update();
                    date = DateTime.now();
                    print(date);
                    print(DateTime.now());

                    count();
                    bulidData = readOneMonth();
                    test(context);
                    update();
                  });
            });

  }

  AlertDialog alert(BuildContext context )=> AlertDialog(
    title: const Text("لا توجد مهام شهريه",textAlign: TextAlign.right,),
    content: const Text("يرجى اضافه مهمة على  الاقل",textAlign: TextAlign.right,),
    actions: [
   FlatButton(
  child: const Text("اضافه"),
      onPressed: () {
        Navigator.of(context).pop();

        Get.to(MonthTask());


      },
  )     ],
  );

  topSnackPar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(

      backgroundColor: Colors.yellow,
      content: Text(text,style: TextStyle(color: Colors.black),textAlign: TextAlign.end,),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    ));
  }





// @override
// void onInit() async {
//   await readOneMonth(date.year, date.month);
//   await count(date.year, date.month);
//   super.onInit();
// }

}
