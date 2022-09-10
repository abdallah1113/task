import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../colors.dart';
import '../controller/daily_tasks_controller.dart';
import '../controller/tasks_controller.dart';


class MyFlexiableAppBar extends StatelessWidget {

   MyFlexiableAppBar();



  @override
  Widget build(BuildContext context) {


    return  GetBuilder<DailyTasksCon>(
      builder: (value) {
        return Container(
          decoration:   BoxDecoration(
            gradient:  bgAppBare,
          ),
          padding: EdgeInsets.only(bottom: 5,left:10 ,right:10 ,top: MediaQuery.of(context).size.height*0.15),
          child:  Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children:  <Widget>[

                           Row(

                             children: [
                               Expanded(
                                 flex: 25,
                                 child: Column(
                                   children: [
                                     GetBuilder<TasksCon>(
                                         init: TasksCon(),
                                         builder: (TasksCon) {
                                         return Text(
                                            TasksCon.couTaskDone.toString(),
                                             style:  const TextStyle(
                                                 color: Color.fromRGBO(0, 18, 51, 1),
                                                 fontFamily: 'Poppins',
                                                 fontSize: 15
                                             )
                                         );
                                       }
                                     ),
                                     const Text(
                                       'انجزت',
                                         style:  TextStyle(
                                             color: Color.fromRGBO(0, 18, 51, 1),
                                             fontFamily: 'Poppins',
                                             fontSize: 12
                                         )
                                     ),
                                   ],
                                 ),
                               ),
                               SizedBox(height: 40,width: 1,child:Container(color:  Colors.black,)),

                               Expanded(
                                 flex: 50,
                                 child: Column(
                                   children: [
                                     Text(
                                         value.cou.toString(),
                                         style:  const TextStyle(
                                             color: Color.fromRGBO(0, 18, 51, 1),
                                             fontFamily: 'Poppins',
                                             fontSize: 20
                                         )
                                     ),
                                     const Text(
                                         ' المهام الشهريه',
                                         style:  TextStyle(
                                             color: Color.fromRGBO(0, 18, 51, 1),
                                             fontFamily: 'Poppins',
                                             fontSize: 15
                                         )
                                     ),
                                   ],
                                 ),
                               ),
                               Padding(
                                 padding: const EdgeInsets.only(right: 8.0),
                                 child: SizedBox(height: 40,width: 1,child:Container(color:  Colors.black,)),
                               ),

                               Expanded(
                                 flex: 25,
                                 child: Column(
                                   children: [

                                     GetBuilder<TasksCon>(
                                         init: TasksCon(),
                                         builder: (TasksCon) {
                                         return Text(
                                            TasksCon.couTask .toString(),
                                             style:  const TextStyle(
                                                 color: Color.fromRGBO(0, 18, 51, 1),
                                                 fontFamily: 'Poppins',
                                                 fontSize: 15
                                             )
                                         );
                                       }
                                     ),
                                     const Text(
                                         ' المهام الفرعيه  ',
                                         style:  TextStyle(
                                             color: Color.fromRGBO(0, 18, 51, 1),
                                             fontFamily: 'Poppins',
                                             fontSize: 12
                                         )
                                     ),
                                   ],
                                 ),
                               ),


                             ],
                           ),

                         ],
                       ),




                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: <Widget>[
                  //     Padding(
                  //       padding: EdgeInsets.only(bottom: 8.0,left:20),
                  //       child:  Text(
                  //           DateTime.now().year.toString()+'/' +  DateTime.now().month.toString()+'/'+   DateTime.now().day.toString() ,
                  //
                  //           style: const TextStyle(
                  //               color: Color.fromRGBO(0, 24, 69, 1),
                  //               fontFamily: 'Poppins',
                  //               fontSize: 16.0
                  //           )
                  //       ),
                  //     ),
                  //
                  //
                  //     Padding(
                  //       padding:  const EdgeInsets.only(bottom: 8.0,right:25),
                  //       child: Row(children:  <Widget>[
                  //         Text(
                  //           DateFormat('EEEE').format(DateTime.now()).toString(),
                  //           style: const TextStyle(
                  //               color: Color.fromRGBO(0, 24, 69, 1),
                  //               fontFamily: 'Poppins',
                  //               fontSize: 16.0
                  //           ),),
                  //       ],),
                  //     ),
                  //   ],),


                ],)
          ),

        );
      }
    );
  }
}