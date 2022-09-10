class MonthModel{

  final int id;
  final String title;
  final String taskType;
  final int y;
  final int m;


  MonthModel( this.id, this.title,   this.taskType,  this.y,  this.m,  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'taskType':taskType,
      'y':y,
      'm':m,

    };
  }

  MonthModel.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        title = res["title"],
        taskType=res['taskType'],
        y=res['y'],
        m=res['m'];


  @override
  String toString() {
    return 'monthTasks{id: $id, title: $title,taskType: $taskType,y: $y,m: $m}';
  }
}
