import 'package:daily_tasks1/appBar/bg.dart';
import 'package:daily_tasks1/appBar/title_appbar.dart';
import 'package:daily_tasks1/colors.dart';
import 'package:daily_tasks1/controller/daily_tasks_controller.dart';
import 'package:daily_tasks1/controller/tasks_controller.dart';
import 'package:daily_tasks1/db/db_crud.dart';
import 'package:daily_tasks1/model/day_tasks.dart';
import 'package:daily_tasks1/ui/tasks.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import '../controller/month_controller.dart';
import 'add_daily_tasks.dart';

class DailyTasks extends StatefulWidget {
  DateTime date ;

  DailyTasks(this.date) ;

  @override
  _DailyTasksState createState() => _DailyTasksState();
}

class _DailyTasksState extends State<DailyTasks> {
  db_crud db = db_crud();
  MonthController monthController =Get.put(MonthController());



  Future<void> _onRefresh() async {
    setState(() {
      dailyTasksCon.bulidData = dailyTasksCon.readOneMonth();
      dailyTasksCon.count();

    });
  }

  DailyTasksCon dailyTasksCon = Get.put(DailyTasksCon());
  void initState() {

    dailyTasksCon.bulidData = dailyTasksCon.readOneMonth();
    dailyTasksCon.count();
    dailyTasksCon.test(context);
    monthController.count();
    super.initState();
  }


@override
  void setState(VoidCallback fn) {
  dailyTasksCon.test(context);
super.setState(fn);
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DailyTasksCon>(
        init: DailyTasksCon(),
        builder: (conteroller) {

          return Scaffold(
          body: CustomScrollView(
                  slivers:<Widget>[
                    SliverAppBar(
                      title: TitleMyAppBar(widget.date,(){

                        setState(() { dailyTasksCon.test(context);});
                      }),
                      pinned: true,
                      floating: false,
                      expandedHeight: MediaQuery.of(context).size.height*0.25,
                      flexibleSpace: FlexibleSpaceBar(
                        background: MyFlexiableAppBar(),
                      ),
                    ),

                    SliverList(
                      delegate: SliverChildBuilderDelegate(

                              (context, index) {

                            return FutureBuilder<List<DailyTasksModel>>(
                                future: conteroller.bulidData,
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<DailyTasksModel>> snapshot) {
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

                                    return RefreshIndicator(
                                      onRefresh: _onRefresh,
                                      child: Dismissible(
                                          direction: DismissDirection.endToStart,
                                          background: Container(
                                            color: Colors.red,
                                            alignment: Alignment.centerRight,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 3.0),
                                            child: const Icon(Icons.delete_forever),
                                          ),
                                          key: ValueKey<int>(items[index].id),
                                          onDismissed:
                                              (DismissDirection direction) async {
                                            await db.delete(
                                                'dailyTasks', items[index].id);
                                            conteroller.deletAllTasksForDaily(
                                                items[index].id);
                                            setState(() {
                                              items.remove(items[index]);
                                              conteroller.cou -= 1;

                                              conteroller.count();
                                            });
                                          },
                                          child:
                                          items[index].d ==
                                              items[index + 1 >= conteroller.cou.value
                                                  ? index
                                                  : index + 1]
                                                  .d ?

                                          tasksDaily(items,index) :


                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [

                                              tasksDaily(items,index),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .center,
                                                children: [
                                                  Text(items[index + 1].dayName.toString(),
                                                    style: TextStyle(color: Colors.grey,
                                                        fontSize: 18),),
                                                  Text(items[index + 1].d.toString(),
                                                    style: TextStyle(color: Colors.grey,
                                                        fontSize: 18),),
                                                ],
                                              ),
                                            ],
                                          )
                                      ),

                                    );
                                  }
                                }
                            );

                          },childCount: conteroller.cou.value,

                      ),
                    )
                  ],
                ),

          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton:  conteroller.test(context),
        );
      }
    );
  }

Widget tasksDaily( List<DailyTasksModel> items ,int index){

    return  Card(
      child: Container(
        decoration: BoxDecoration(
            gradient: bgList),
        child: ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Tasks(
                        date: widget.date,
                        dayName: items[index].title,
                        dayID: items[index].id,
                      )),
            );
          },
          title: Text(
            items[index].title,
            textAlign: TextAlign.right,
            style: TextStyle(color: Color.fromRGBO(
                255, 190, 11, 1),
            ),

          ),
          subtitle:Text(items[index].subtitle == ''  ? 'مهمه جديده':items[index].subtitle,
            style: TextStyle(
                color: Colors.grey),
            textAlign: TextAlign.right,

          ) ,
          leading: Column(
            mainAxisAlignment: MainAxisAlignment
                .center,
            children: [
              Wrap(
                children: [
                  Text(
                    items[index].y.toString(),
                    style: const TextStyle(
                        fontSize: 16),
                  ),
                  const Text('/'),
                  Text(
                    items[index].m.toString(),
                    style: const TextStyle(
                        fontSize: 16),
                  ),
                  const Text('/'),
                  Text(
                    items[index].d.toString(),
                    style: const TextStyle(
                        fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 7),
              Text(
                items[index].dayName,
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ),
      ),
    );

}
}
