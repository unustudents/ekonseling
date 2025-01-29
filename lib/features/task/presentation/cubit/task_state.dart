part of 'task_cubit.dart';

class TaskState extends Equatable {
  final bool isLoading;
  final String isAlert;
  final String error;
  final List<Map<String, dynamic>> week;
  final List<String> uploadUrl;
  final List<Map<String, dynamic>> question;
  final String successUpload;
  final bool downloading;
  final double progress;
  final String filePath;
  final String fileName;
  final bool fileExist;
  final bool isPermission;
  final List<PlatformFile> fileSelected;

  const TaskState({
    this.isLoading = false,
    this.isAlert = '',
    this.error = '',
    this.week = const [],
    this.uploadUrl = const [],
    this.question = const [],
    this.successUpload = '',
    this.downloading = false,
    this.progress = 0,
    this.filePath = '',
    this.fileName = '',
    this.fileExist = false,
    this.isPermission = false,
    this.fileSelected = const [],
  });

  TaskState copyWith({
    bool? isLoading,
    String? isAlert,
    String? error,
    List<Map<String, dynamic>>? week,
    List<String>? uploadUrl,
    List<Map<String, dynamic>>? question,
    String? successUpload,
    bool? downloading,
    double? progress,
    String? filePath,
    String? fileName,
    bool? fileExist,
    bool? isPermission,
    List<PlatformFile>? fileSelected,
  }) {
    return TaskState(
      isLoading: isLoading ?? this.isLoading,
      isAlert: isAlert ?? this.isAlert,
      error: error ?? this.error,
      week: week ?? this.week,
      uploadUrl: uploadUrl ?? this.uploadUrl,
      question: question ?? this.question,
      successUpload: successUpload ?? this.successUpload,
      downloading: downloading ?? this.downloading,
      progress: progress ?? this.progress,
      filePath: filePath ?? this.filePath,
      fileName: fileName ?? this.fileName,
      fileExist: fileExist ?? this.fileExist,
      isPermission: isPermission ?? this.isPermission,
      fileSelected: fileSelected ?? this.fileSelected,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        error,
        week,
        uploadUrl,
        question,
        successUpload,
        isAlert,
        downloading,
        progress,
        filePath,
        fileName,
        fileExist,
        isPermission,
        fileSelected,
      ];
}
