import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/task_model.dart';
import '../../utils/local_database_helper.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());

  static TaskCubit get(context) {
    return BlocProvider.of(context);
  }

  List<TaskModel> doneTaskList = [];
  List<TaskModel> inProgressTaskList = [];

  final LocalDatabaseHelper _localDatabaseHelper = LocalDatabaseHelper();

  void intDatabase() async {
    emit(IntDatabaseLoading());
    try {
      await _localDatabaseHelper.initDatabase(
        databasePathName: "task_app",
        onCreate: (database, version) async {
          await database.execute(
            "CREATE TABLE tasks (id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT NOT NULL,level TEXT NOT NULL,dateTime TEXT NOT NULL,is_done INTEGER NOT NULL DEFAULT 0)",
          );
        },
      );
      emit(IntDatabaseSuccess());
    } catch (error) {
      emit(IntDatabaseError());
    }
  }

  //
  // void getTaskList() async {
  //   emit(GetTaskListLoading());
  //   try {
  //     final List<Map<String, dynamic>> list = await localDatabaseHelper.getData(
  //       tableName: "tasks",
  //     );
  //     list.forEach(
  //       ((element) {
  //         taskList.add(TaskModel.fromMap(element));
  //       }),
  //     );
  //     emit(GetTaskListSuccess());
  //   } catch (error) {
  //     emit(GetTaskListError());
  //   }
  // }

  Future<void> getInProgressTaskList() async {
    emit(GetInProgressTaskListLoading());
    try {
      final List<Map<String, dynamic>> list = await _localDatabaseHelper
          .getData(
            tableName: "tasks",
            where: "is_done = 0",
          );
      inProgressTaskList.clear();
      for (var element in list) {
        inProgressTaskList.add(TaskModel.fromMap(element));
      }

      emit(GetInProgressTaskListSuccess());
    } catch (error) {
      emit(GetInProgressTaskListError());
    }
  }

  Future<void> getDoneTaskList() async {
    emit(GetDoneTaskListLoading());
    try {
      final List<Map<String, dynamic>> list = await _localDatabaseHelper
          .getData(
            tableName: "tasks",
            where: "is_done = 1",
          );
      doneTaskList.clear();
      for (var element in list) {
        doneTaskList.add(TaskModel.fromMap(element));
      }

      emit(GetDoneTaskListSuccess());
    } catch (error) {
      emit(GetDoneTaskListError());
    }
  }

  Future<void> addNewTask({required TaskModel taskModel}) async {
    emit(AddNewTaskLoading());
    try {
      await _localDatabaseHelper.insertToDatabase(
        values: taskModel.toMap(),
        tableName: "tasks",
      );
      emit(AddNewTaskSuccess());
    } catch (error) {
      emit(AddNewTaskError());
    }
  }

  Future<void> makeTaskDone({required int taskId}) async {
    emit(MakeTaskDoneLoading());
    try {
      await _localDatabaseHelper.updateDatabase(
        values: {"is_done": 1},
        tableName: "tasks",
        query: "id = $taskId",
      );

      emit(MakeTaskDoneSuccess(taskId: taskId));
    } catch (error) {
      emit(MakeTaskDoneError());
    }
  }

  Future<void> removeTask({required int removeId}) async {
    emit(RemoveTaskLoading());
    try {
      await _localDatabaseHelper.deleteDatabase(
        tableName: "tasks",
        query: "id = $removeId",
      );
      emit(RemoveTaskSuccess(removeId: removeId));
    } catch (error) {
      emit(RemoveTaskError());
    }
  }

  Future<void> editTask({required TaskModel taskModel}) async {
    emit(EditTaskLoading());
    try {
      await _localDatabaseHelper.updateDatabase(
        values: taskModel.toMap(),
        tableName: "tasks",
        query: "id = ${taskModel.id}",
      );
      emit(EditTaskSuccess());
    } catch (error) {
      emit(EditTaskError());
    }
  }
}
