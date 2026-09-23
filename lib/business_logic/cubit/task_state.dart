part of 'task_cubit.dart';

// sealed class can't extend from outside the file
sealed class TaskState {}

final class TaskInitial extends TaskState {}

final class IntDatabaseLoading extends TaskState {}

final class IntDatabaseSuccess extends TaskState {}

final class IntDatabaseError extends TaskState {}

final class GetTaskListLoading extends TaskState {}

final class GetTaskListSuccess extends TaskState {}

final class GetTaskListError extends TaskState {}

final class GetInProgressTaskListLoading extends TaskState {}

final class GetInProgressTaskListSuccess extends TaskState {}

final class GetInProgressTaskListError extends TaskState {}

final class GetDoneTaskListLoading extends TaskState {}

final class GetDoneTaskListSuccess extends TaskState {}

final class GetDoneTaskListError extends TaskState {}

final class AddNewTaskLoading extends TaskState {}

final class AddNewTaskSuccess extends TaskState {}

final class AddNewTaskError extends TaskState {}

final class MakeTaskDoneLoading extends TaskState {}

final class MakeTaskDoneSuccess extends TaskState {
  final int taskId;

  MakeTaskDoneSuccess({required this.taskId});
}

final class MakeTaskDoneError extends TaskState {}

final class RemoveTaskLoading extends TaskState {}

final class RemoveTaskSuccess extends TaskState {
  final int removeId;

  RemoveTaskSuccess({required this.removeId});
}

final class RemoveTaskError extends TaskState {}

final class EditTaskLoading extends TaskState {}

final class EditTaskSuccess extends TaskState {}

final class EditTaskError extends TaskState {}
