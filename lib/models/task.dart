class Task {
  final int id;
  final String title;
  final String description;
  final String time;
  bool isDone;
  Task({this.time, this.id, this.title, this.description, this.isDone = false});
  
  void toggleDone() {
    isDone = !isDone;
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'desc': description, 'time': time,'isDone':isDone};
  }
}
