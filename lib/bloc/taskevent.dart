import '../model/taskdatas.dart';

abstract class TaskEvent {}

class AddTask extends TaskEvent {
  final Task task;

  AddTask(this.task);
}

class FetchTasks extends TaskEvent {}
