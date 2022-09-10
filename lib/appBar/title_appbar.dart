
import 'package:daily_tasks1/ui/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ui/month_task.dart';


class TitleMyAppBar extends StatelessWidget {
  DateTime date ;
  Function set;

  final double barHeight = 66.0;

   TitleMyAppBar(this.date,this.set, {Key? key}) : super(key: key);

  @override



  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:  <Widget>[
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Get.to( Profile(set));
                  },
                  icon: const Icon(
                    Icons.person,
                    color: Color.fromRGBO(0, 18, 51, 1),
                  )),
              IconButton(
                  onPressed: () {
                    Get.to(MonthTask());
                  },
                  icon: Icon(
                    Icons.assignment,
                    color: Color.fromRGBO(0, 18, 51, 1),
                  )),
            ],
          ),
          const Text(
              'المهام الشهريه',
              textAlign: TextAlign.right,
              style: TextStyle(

                  color: Color.fromRGBO(0, 18, 51, 1),
                  fontFamily: 'Poppins',
                  fontSize: 20.0
              ),
            ),



        ],
      ),
    );
  }

}
