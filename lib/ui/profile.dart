import 'package:daily_tasks1/controller/daily_tasks_controller.dart';
import 'package:daily_tasks1/controller/month_controller.dart';
import 'package:daily_tasks1/controller/tasks_controller.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/utils.dart';

import '../colors.dart';
import '../model/day_tasks.dart';

class Profile extends StatefulWidget {
  Function set;
   Profile(this.set,{Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    TasksCon tasksCon = Get.put(TasksCon());

    return Scaffold(
      appBar: AppBar(
      ),
      body: GetBuilder<DailyTasksCon>(
        init: DailyTasksCon(),
        builder: (controller) {
           return FutureBuilder<List<DailyTasksModel>>(
             future: controller.reads(),
               builder: (context,  AsyncSnapshot<List<DailyTasksModel>> snapshot) {
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
              } else {
                final items = snapshot.data ?? <DailyTasksModel>[];
                return  ListView.builder(itemBuilder: (context, index) {
                        return items[index].m != items[index + 1].m
                            ?            GetBuilder<TasksCon>(
                            init: TasksCon(),
                            builder: (c) {
                              return GetBuilder<MonthController>(
                                  init: MonthController(),
                                  builder: (cc) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListTile(

                                        title:Text(
                                            ' ${items[index].y}/${items[index].m}',textAlign: TextAlign.center),
                                        onTap: () {
                                          controller.date=DateTime(items[index].y , items[index].m);

                                          controller.bulidData=  controller.readOneMonth();
                                          controller.count();
                                          cc.date=DateTime(items[index].y , items[index].m);
                                         cc.bulidData= cc.readOneMonth();
                                          print(controller.date);
                                          print(DateTime.now().month);
                                          widget.set();
                                        controller.update();
                                          c.count(items[index].y , items[index].m);
                                          cc.update();

                                          c.update();
                                          controller.update();
                                          Navigator.pop(context);
                                        },
                                      ),
                                    );
                                  }
                              );
                            }
                        )
                            :items.last == items[index+1]?
                        GetBuilder<MonthController>(
                          init: MonthController(),
                          builder: (cc) {
                            return GetBuilder<TasksCon>(
                              init: TasksCon(),
                              builder: (c) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: bgList
                                    ),
                                    child: ListTile(
                                      title:Text(
                                          ' ${items[index].y}/${items[index].m}',textAlign: TextAlign.center),
                                      onTap: () {
                                        controller.date=DateTime(items[index].y , items[index].m,DateTime.now().day,DateTime.now().hour,DateTime.now().minute,);
                                        print(controller.date);
                                        print(DateTime.now().month);

                                        controller.bulidData=  controller.readOneMonth();
                                        controller.count();
                                        cc.date=DateTime(items[index].y , items[index].m);

                                        cc.bulidData= cc.readOneMonth();
                                        widget.set();

                                        cc.update();
                                          c.count(items[index].y , items[index].m);
                                          c.update();
                                        controller.update();
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                );
                              }
                            );
                          }
                        )
                            :const SizedBox();
                      },itemCount:items.length-1 ,
                );
              }
            }
          );
        }
      ),
    );
  }
}
