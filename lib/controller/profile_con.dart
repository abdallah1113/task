import 'package:get/state_manager.dart';

import '../db/db_crud.dart';
import '../model/day_tasks.dart';

class ProfileCon extends GetxController{
  db_crud db = db_crud();

  Future<List<DailyTasksModel>> reads() async {
    final db1 = await db.initializeDB();

    final List<Map<String, dynamic>> queryResult =
    await db1.query('dailyTasks');

    return queryResult.map((e) => DailyTasksModel.fromMap(e)).toList();
  }
}