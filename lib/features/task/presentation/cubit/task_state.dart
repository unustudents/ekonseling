part of 'task_cubit.dart';

class TaskState extends Equatable {
  final bool isLoading;
  final bool isPermission;
  final String error;
  final List<Map<String, dynamic>> week;

  const TaskState({
    this.isLoading = false,
    this.isPermission = false,
    this.error = '',
    this.week = const [],
  });

  TaskState copyWith({
    bool? isLoading,
    String? error,
    List<Map<String, dynamic>>? week,
    bool? isPermission,
  }) {
    return TaskState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      week: week ?? this.week,
      isPermission: isPermission ?? this.isPermission,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        error,
        week,
        isPermission,
      ];
}
