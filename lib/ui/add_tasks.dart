import 'package:daily_tasks1/controller/tasks_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';


class AddTasks extends StatelessWidget {
 final int dayId;
 DateTime date ;

  AddTasks({required this.dayId,required this.date});

  @override
  Widget build(BuildContext context) {
    String? newTaskTitle;
    return GetBuilder<TasksCon>(
      init:TasksCon() ,
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
                  decoration: const InputDecoration(label: Text('اضافه مهمه',style: TextStyle(fontSize: 20),textAlign: TextAlign.end,),),

                  style: TextStyle(color: Colors.white),
                  autofocus: true,
                  textAlign: TextAlign.center,
                  onChanged: (newText) {
                    newTaskTitle = newText;
                  },
                  onSubmitted: (value){
                    controller.insertTask(controller.newID(dayId), newTaskTitle!, dayId);
                    print('dayID$dayId');
                    controller.newID(dayId);
                    controller.couTask += 1;

                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(height: 30),
              TextButton(
                onPressed: () {
                  controller.insertTask(controller.newID(dayId), newTaskTitle!, dayId);
                  print('dayID$dayId');
                  controller.newID(dayId);
                  controller.couTask += 1;

                  Navigator.pop(context);
                },
                child: Text('اضافه'),
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