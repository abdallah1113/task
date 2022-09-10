import 'dart:async';
import 'package:daily_tasks1/controller/tasks_controller.dart';
import 'package:daily_tasks1/db/db_crud.dart';
import 'package:daily_tasks1/model/task_model.dart';
import 'package:daily_tasks1/ui/add_tasks.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../colors.dart';
import '../controller/daily_tasks_controller.dart';

class Tasks extends StatefulWidget {
  int dayID;
  String dayName;
  DateTime date ;

  Tasks({Key? key, required this.dayID, required this.dayName,required this.date})
      : super(key: key);

  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  db_crud db = db_crud();
  TasksCon tasksCon = Get.put(TasksCon());
  DailyTasksCon dailyTasksCon = Get.put(DailyTasksCon());

  @override
  void initState() {
    tasksCon.buildTasks = tasksCon.readTasks(widget.dayID);
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        centerTitle: true,
        title: Text(widget.dayName,
            style: TextStyle(color: Color.fromRGBO(0, 24, 69, 1))),
        actions: [Row()],
      ),
      body: GetBuilder<TasksCon>(
          init: TasksCon(),
          builder: (controller) {
            return Padding(
              padding: const EdgeInsets.only(right: 15, left: 13, bottom: 35),
              child: FutureBuilder<List<TaskModel>>(
                  future: controller.buildTasks,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<TaskModel>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.data == null) {
                      return const Center(
                        child: Center(child: Text('لا يوجد بيانات')),
                      );
                    } else {
                      final items = snapshot.data ?? <TaskModel>[];
                      return RefreshIndicator(
                        onRefresh: () async {
                          print('ds');
                        },
                        child: ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Dismissible(
                              direction: DismissDirection.endToStart,
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: const Icon(Icons.delete_forever),
                              ),
                              key: ValueKey<int>(items[index].id),
                              onDismissed:
                                  (DismissDirection direction) async {
                                await controller.deleteItme(
                                    items[index].id, items[index]);
                                controller.couTask -= 1;
                                controller.couTaskDone -=1;
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 8,
                                  left: 10,
                                  right: 10,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                      gradient: taskColor,
                                      borderRadius:BorderRadius.circular(25)
                                  ),
                                  child: ListTile(
                                    shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color:
                                                Color.fromRGBO(0, 24, 69, 1),
                                            width: 1),
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    tileColor:
                                        Color.fromRGBO(255, 190, 11, 1),
                                    textColor:
                                        const Color.fromRGBO(0, 18, 51, 1),
                                    onTap: () =>
                                        controller.changeBoolValue(index),
                                    title: Text(
                                      items[index].title,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        decoration: items[index].is_done == 1
                                            ? TextDecoration.lineThrough
                                            : TextDecoration.none,
                                      ),
                                    ),
                                    leading: Checkbox(
                                      activeColor: Color.fromRGBO(0, 24, 69, 1),
                                      shape: RoundedRectangleBorder(borderRadius:
                                              BorderRadius.circular(15.0)),
                                      value: items[index].is_done == 0
                                          ? false
                                          : true,
                                      onChanged: (bool) {
                                        controller.changeBoolValue(index);

                                      },
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  }),
            );
          }),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Color.fromRGBO(0, 18, 51, 1)),
          borderRadius: BorderRadius.circular(50),
        ),
        child:   DateTime.now().year == dailyTasksCon.date.year && DateTime.now().month == dailyTasksCon.date.month?
        FloatingActionButton(
          backgroundColor:mainColor,
          onPressed: () {

            tasksCon.newID(widget.dayID);
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: AddTasks(
                      dayId: widget.dayID,date: widget.date,
                    )),
              ),
            );
          },
          child: const Icon(Icons.add, color: Color.fromRGBO(0, 24, 69, 1)),
        ): SizedBox(),
      ),
    );
  }


}
