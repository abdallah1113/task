import 'package:daily_tasks1/ui/daily_tasks.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'controller/daily_tasks_controller.dart';

void main() {
WidgetsFlutterBinding.ensureInitialized();
DailyTasksCon dailyTasksCon = Get.put(DailyTasksCon());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        brightness: Brightness.light,

      ),
      darkTheme:ThemeData(
        cardColor: const Color.fromRGBO(0, 18, 51, 1),
        backgroundColor: Colors.deepOrangeAccent,
        brightness: Brightness.light,
        scaffoldBackgroundColor:const Color.fromRGBO(0, 18, 51, 1),
        listTileTheme: const ListTileThemeData(textColor: Colors.white),
        primarySwatch: Colors.amber,
      ) ,
      home: AnimatedSplashScreen(
        backgroundColor: const Color.fromRGBO(0, 18, 51, 1),
        nextScreen:  DailyTasks(DateTime.now()),
        splash:SpinKitFoldingCube(
          color:Colors.amber ,
        ) ,
      ),
    );
  }
}

