  class TaskModel{

  final int id;
  final String title;
  final String dayName;

  final int y;
  final int m;
  final int is_done;
  final int d;
  final int h;
  final int mi;
  final int dayID;

  TaskModel( this.id, this.title,   this.is_done,  this.y,  this.m,  this.d,  this.h,  this.mi,  this.dayName, this.dayID);

  Map<String, dynamic> toMap() {
  return {
  'id': id,
  'title': title,
  'is_done':is_done,
  'y':y,
  'm':m,
  'd':d,
  'h':h,
  'mi':mi,
  'dayName':dayName,
  'dayId':dayID,

  };
  }

  TaskModel.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        title = res["title"],
        is_done=res['is_done'],
        dayName=res['dayName'],
        dayID=res['dayID'],
        y=res['y'],
        m=res['m'],
        d=res['d'],
        mi=res['mi'],
        h=res['h'];

// Implement toString to make it easier to see information about
// each dog when using the print statement.
  @override
  String toString() {
  return 'dayTasks{id: $id, title: $title,is_done: $is_done,y: $y,m: $m,d: $d,h: $h,mi: $mi,dayName: $dayName,dayId: $dayID}';
  }
  }
