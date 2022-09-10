import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../controller/month_controller.dart';

class AddMonthTasks extends StatelessWidget {

  AddMonthTasks();

  @override
  Widget build(BuildContext context) {
    String? newTaskTitle;
    return GetBuilder<MonthController>(
        init:MonthController() ,
        builder: (controller) {
          return Container(
            color: const Color.fromRGBO(0, 18, 51, 1),

            padding: EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    style: TextStyle(color: Colors.white),

                    autofocus: true,
                    textAlign: TextAlign.center,
                    onChanged: (newText) {
                      newTaskTitle = newText;
                    },
                  ),
                ),
                const SizedBox(height: 30),
                TextButton(
                  onPressed: () {
                    controller.insertData(controller.newID(), newTaskTitle!, 'dayId');
                    controller.newID();
                    controller.op=[];
                    controller.addOp();
                    controller.count();

                    Navigator.pop(context);

                  },
                  child: const Text('اضافه'),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.amber,
                    primary: const Color.fromRGBO(0, 18, 51, 1),

                  ),

                ),

              ],
            ),
          );
        }
    );
  }
}