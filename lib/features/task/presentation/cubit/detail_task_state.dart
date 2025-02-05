part of 'detail_task_cubit.dart';

class DetailTaskState extends Equatable {
  // final bool isLoading;
  // final bool isDownloading;
  final bool isFileExist;
  final bool isPermission;
  final DetailTaskStatus status;
  final String msg;
  final String error;
  final String success;
  final String filePath;
  final String fileName;
  final double progress;
  final List<PlatformFile> fileSelected;

  const DetailTaskState({
    // this.isLoading = false,
    // this.isDownloading = false,
    this.isFileExist = false,
    this.isPermission = false,
    this.status = DetailTaskStatus.initial,
    this.msg = '',
    this.error = '',
    this.success = '',
    this.filePath = '',
    this.fileName = '',
    this.progress = 0,
    this.fileSelected = const [],
  });

  DetailTaskState copyWith({
    // bool? isLoading,
    // bool? isDownloading,
    bool? isFileExist,
    bool? isPermission,
    DetailTaskStatus? status,
    String? msg,
    String? error,
    String? success,
    String? filePath,
    String? fileName,
    double? progress,
    List<PlatformFile>? fileSelected,
  }) {
    return DetailTaskState(
      // isLoading: isLoading ?? this.isLoading,
      // isDownloading: isDownloading ?? this.isDownloading,
      isFileExist: isFileExist ?? this.isFileExist,
      isPermission: isPermission ?? this.isPermission,
      status: status ?? this.status,
      msg: msg ?? this.msg,
      error: error ?? this.error,
      success: success ?? this.success,
      filePath: filePath ?? this.filePath,
      fileName: fileName ?? this.fileName,
      progress: progress ?? this.progress,
      fileSelected: fileSelected ?? this.fileSelected,
    );
  }

  @override
  List<Object> get props => [
        // isLoading,
        // isDownloading,
        isFileExist,
        isPermission,
        status,
        msg,
        error,
        success,
        filePath,
        fileName,
        progress,
        fileSelected,
      ];
}

enum DetailTaskStatus { initial, loading, success, error, downloading }
