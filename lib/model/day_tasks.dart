class DailyTasksModel{

  final int id;
  final String title;
  final String dayName;
  final String subtitle;

  final int y;
  final int m;
  final int d;
  final int h;
  final int mi;

  DailyTasksModel( this.id, this.title,this.subtitle,this.y,  this.m,  this.d,  this.h,  this.mi,  this.dayName);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'y':y,
      'm':m,
      'd':d,
      'h':h,
      'mi':mi,
      'dayName':dayName,

    };
  }

  DailyTasksModel.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        title = res["title"],
        subtitle=res['subtitle'],
      dayName=res['dayName'],
        y=res['y'],
        m=res['m'],
        d=res['d'],
        mi=res['mi'],
        h=res['h'];

// Implement toString to make it easier to see information about
// each dog when using the print statement.
  @override
  String toString() {
    return 'dayTasks{id: $id, title: $title, subtitle: $subtitle, $y,m: $m,d: $d,h: $h,mi: $mi,dayName: $dayName}';
  }
}