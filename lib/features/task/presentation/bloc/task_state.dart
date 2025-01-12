part of 'task_bloc.dart';

class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class TaskEmpty extends TaskState {
  final String message;

  const TaskEmpty([this.message = 'Admin belum menambahkan tugas']);

  @override
  List<Object> get props => [message];
}

class TaskLoaded extends TaskState {
  final List<Map<String, dynamic>> tasks;
  const TaskLoaded({required this.tasks});

  @override
  List<Object> get props => [tasks];
}

class TaskError extends TaskState {
  final String message;
  const TaskError({required this.message});

  @override
  List<Object> get props => [message];
}

class TaskLoading extends TaskState {
  final bool isLoading;

  const TaskLoading([this.isLoading = true]);

  @override
  List<Object> get props => [isLoading];
}
