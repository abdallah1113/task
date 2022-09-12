import 'package:daily_tasks1/controller/daily_tasks_controller.dart';
import 'package:daily_tasks1/controller/month_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../colors.dart';

class AddTaskScreen extends StatefulWidget {
  AddTaskScreen();

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  bool swo = true;
  String? newTaskTitle;
  String newSub = '';

  Widget build(BuildContext context) {
    List<String> x = [];

    return GetBuilder<DailyTasksCon>(
        init: DailyTasksCon(),
        builder: (value) {
          return Container(
            color: const Color.fromRGBO(0, 18, 51, 1),
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.white10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Switch(
                          value: swo,
                          onChanged: (value) {
                            newTaskTitle = null;
                            setState(() {
                              swo = value;
                            });
                          }),
                      const Text('ختيار مهمه رئيسية',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.amber,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: swo == true
                      ? GetBuilder<MonthController>(
                          init: MonthController(),
                          builder: (c ) {
                            return Directionality(
                              textDirection: TextDirection.rtl,
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  width: 1.0,
                                  color: Colors.white10,
                                )),
                                child: DropdownButton(
                                  isExpanded: true,
                                  underline: SizedBox(),
                                  iconEnabledColor: Colors.amber,
                                  style: const TextStyle(color: Colors.white),
                                  dropdownColor:
                                      const Color.fromRGBO(0, 24, 69, 1),
                                  alignment: Alignment.centerRight,
                                  hint: const Text(
                                    'اختيار المهمه',
                                    style: TextStyle(
                                        color: Color.fromRGBO(218, 162, 15, 1),
                                        fontSize: 15),
                                  ),
                                  value: newTaskTitle,
                                  autofocus: true,
                                  onChanged: (String? value) {
                                    setState(() {
                                      newTaskTitle = value!;
                                    });
                                  },
                                  items: c.op.map((e) {
                                    return DropdownMenuItem(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Center(
                                              child: Text(e,
                                                  textAlign: TextAlign.right)),
                                        ],
                                      ),
                                      value: e,
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          })
                      : Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(218, 162, 15, 1))),
                              label: Text(
                                'عنوان رئيسي',
                              ),
                              labelStyle: TextStyle(
                                  color: Color.fromRGBO(218, 162, 15, 1),
                                  fontSize: 15),
                            ),
                            textAlign: TextAlign.start,
                            style: const TextStyle(color: Colors.white),
                            autofocus: true,
                            onChanged: (newText) {
                              newTaskTitle = newText;
                            },
                            scrollPadding: EdgeInsets.only(right: 10),
                            onSubmitted: (v) {
                              if (newTaskTitle != null && newTaskTitle != '') {
                                value.insertData(
                                    value.newID(), newTaskTitle!, newSub);
                                value.newID();

                                Navigator.pop(context);
                                value.newID();
                                setState(() {
                                  value.cou += 1;
                                });
                              } else {
                                if (swo == true) {
                                  Navigator.of(context).pop();

                                  value.topSnackPar(
                                      context, 'يرجى اختيار مهمه');
                                } else {
                                  Navigator.of(context).pop();
                                  value.topSnackPar(context, 'يرجى كتابه مهمه');
                                }
                              }
                            },
                          ),
                        ),
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    cursorColor: Colors.white,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(218, 162, 15, 1))),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white10, width: 1),
                      ),
                      label: Text(
                        'عنوان ثانوي',
                      ),
                      labelStyle: TextStyle(
                        color: Color.fromRGBO(218, 162, 15, 1),
                        fontSize: 15,
                      ),
                    ),
                    textAlign: TextAlign.start,
                    onChanged: (newText) {
                      newSub = newText;
                    },
                  ),
                ),
                const SizedBox(height: 30),
                TextButton(
                  onPressed: () {
                    if (newTaskTitle != null && newTaskTitle != '') {
                      value.insertData(value.newID(), newTaskTitle!, newSub);
                      value.newID();

                      Navigator.pop(context);
                      value.newID();
                      setState(() {
                        value.cou += 1;
                      });
                    } else {
                      if (swo == true) {
                        Navigator.of(context).pop();

                        value.topSnackPar(context, 'يرجى اختيار مهمه');
                      } else {
                        Navigator.of(context).pop();
                        value.topSnackPar(context, 'يرجى كتابه مهمه');
                      }
                    }
                  },
                  child: const Text(
                    'اضافه',
                    style: TextStyle(fontSize: 15),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: mainColor,
                    primary: const Color.fromRGBO(0, 18, 51, 1),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
