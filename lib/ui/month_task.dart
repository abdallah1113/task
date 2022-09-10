import 'package:daily_tasks1/controller/month_controller.dart';
import 'package:daily_tasks1/model/month_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../colors.dart';
import '../controller/daily_tasks_controller.dart';
import '../db/db_crud.dart';
import 'add_month_tasks.dart';

class MonthTask extends StatefulWidget {
   MonthTask({Key? key}) : super(key: key);

  @override
  State<MonthTask> createState() => _MonthTaskState();
}

class _MonthTaskState extends State<MonthTask> {
  @override
  DailyTasksCon dailyTasksCon = Get.put(DailyTasksCon());

  MonthController monthController=Get.put(MonthController());
  DateTime date =DateTime.now();
  db_crud db = db_crud();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: mainColor,
        title: Text("المهام الشهريه"),
        centerTitle: true,
      ) ,
      body: GetBuilder<MonthController>(
        init: MonthController(),
        builder: (controller) {

          return FutureBuilder<List<MonthModel>>(
            future: controller.bulidData,
            builder: (context, snapshot) {
            if (snapshot.connectionState ==
                ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.data == null) {
              return const Center(
                child: Center(child: Text('لا يوجد بيانات')),
              );
            }else{
              final items = snapshot.data ?? <MonthModel>[];
              return ListView.builder(
                  itemCount: items.length,
                      itemBuilder: (context, index) =>
                          Dismissible(
                            key: ValueKey<int>(items[index].id),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 3.0),
                              child: const Icon(Icons.delete_forever),),
                            onDismissed: (DismissDirection direction) async {
                              controller.count();
                              await db.delete(
                                  'monthTasks', items[index].id);
                              setState(() {
                                items.remove(items[index]);
                                controller.addOp();
                              });
                            },child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: bgList
                                ),
                                child: ListTile(
                                    shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color:
                                            Color.fromRGBO(0, 24, 69, 1),
                                            width: 1),
                                        borderRadius:
                                        BorderRadius.circular(25)),
                                    title: Text(

                                      items[index].title,
                                  style: const TextStyle(color: Colors.white),
                                      textAlign: TextAlign.right,

                                    )),
                              ),
                            ),
                          ));
                }
          });
        }
      ),
      floatingActionButton:  DateTime.now().year == dailyTasksCon.date.year && DateTime.now().month == dailyTasksCon.date.month?
      FloatingActionButton(
        backgroundColor: mainColor,
          child: const Icon(Icons.add),
          onPressed: () {
        monthController.newID();
        print( monthController.newID());
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) => SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child:  AddMonthTasks()),
          ),

        );
      }):SizedBox(),
    );
  }
}
