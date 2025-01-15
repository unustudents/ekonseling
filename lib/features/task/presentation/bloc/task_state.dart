// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'task_bloc.dart';

class TaskState extends Equatable {
  final bool isLoading;
  final String error;
  final List<Map<String, dynamic>> week;
  final List<String> uploadUrl;
  final List<Map<String, dynamic>> question;
  final String successUpload;

  const TaskState({
    required this.isLoading,
    required this.error,
    required this.week,
    required this.uploadUrl,
    required this.question,
    required this.successUpload,
  });

  factory TaskState.initial() {
    return TaskState(
      error: '',
      week: [],
      isLoading: false,
      uploadUrl: [],
      question: [],
      successUpload: '',
    );
  }

  TaskState copyWith({
    bool? isLoading,
    String? error,
    List<Map<String, dynamic>>? week,
    List<String>? uploadUrl,
    List<Map<String, dynamic>>? question,
    String? successUpload,
  }) {
    return TaskState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      week: week ?? this.week,
      uploadUrl: uploadUrl ?? this.uploadUrl,
      question: question ?? this.question,
      successUpload: successUpload ?? this.successUpload,
    );
  }

  @override
  List<Object> get props => [isLoading, error, week, uploadUrl, question, successUpload];
}
