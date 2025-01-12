part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class TaskLoadEvent extends TaskEvent {}

class UploadTaskEvent extends TaskEvent {
  final String taskId;
  final String filePath;

  const UploadTaskEvent({required this.taskId, required this.filePath});

  @override
  List<Object> get props => [taskId, filePath];
}
