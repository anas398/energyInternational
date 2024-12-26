class Task {
  int? id;
  String taskName;
  String taskDescription;
  String employeeName;

  Task({
    this.id,
    required this.taskName,
    required this.taskDescription,
    required this.employeeName,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'taskName': taskName,
      'taskDescription': taskDescription,
      'employeeName': employeeName,
    };
  }

  static Task fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      taskName: map['taskName'],
      taskDescription: map['taskDescription'],
      employeeName: map['employeeName'],
    );
  }
}
