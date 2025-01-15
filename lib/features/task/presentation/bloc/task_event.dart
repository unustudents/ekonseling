part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class TaskLoadEvent extends TaskEvent {}

class UploadFileEvent extends TaskEvent {
  final List<PlatformFile> files;

  const UploadFileEvent({
    required this.files,
  });

  @override
  List<Object> get props => [files];
}
