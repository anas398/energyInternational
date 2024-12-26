import 'package:bloc/bloc.dart';
import 'package:energy_international/db/dbhelper.dart';

import 'taskevent.dart';
import 'taskstate.dart';


class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  TaskBloc() : super(TaskInitial()) {
    on<AddTask>((event, emit) async {
      await _databaseHelper.insertTask(event.task);
      add(FetchTasks());
    });

    on<FetchTasks>((event, emit) async {
      emit(TaskLoading());
      final tasks = await _databaseHelper.fetchTasks();
      emit(TaskLoaded(tasks));
    });
  }
}
