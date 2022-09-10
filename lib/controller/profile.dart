import 'package:get/get.dart';

import '../db/db_crud.dart';
import '../model/task_model.dart';
class ProfileController extends GetxController{
  db_crud db = db_crud();
  Future<List<TaskModel>>? buildProfile;

  Future<List< TaskModel>>read() async {

    final db1 = await db.initializeDB();

    final List<Map<String, dynamic>> queryResult = await db1.rawQuery('SELECT * FROM "Tasks" ORDER BY id DESC');

    return queryResult.map((e) =>TaskModel.fromMap(e)).toList();
  }



}