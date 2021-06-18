class Todo {
  final int id;
  final int proId;
  final String title;
  final int isDone;
  Todo({this.id, this.proId, this.title, this.isDone});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'proId': proId,
      'title': title,
      'isDone': isDone,
    };
  }
}