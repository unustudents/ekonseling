// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'task_bloc.dart';

class TaskState extends Equatable {
  final bool isLoading;
  final String error;
  final List<Map<String, dynamic>> week;

  const TaskState({
    required this.isLoading,
    required this.error,
    required this.week,
  });

  factory TaskState.initial() {
    return TaskState(
      error: '',
      week: [],
      isLoading: false,
    );
  }

  TaskState copyWith({
    bool? isLoading,
    String? error,
    List<Map<String, dynamic>>? week,
  }) {
    return TaskState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      week: week ?? this.week,
    );
  }

  @override
  List<Object> get props => [error];
}
