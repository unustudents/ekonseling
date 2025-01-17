// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class LoadWeekEvent extends TaskEvent {}

class LoadQuestionsEvent extends TaskEvent {
  final String weekId;

  const LoadQuestionsEvent({
    required this.weekId,
  });

  @override
  List<Object> get props => [weekId];
}

class DownloadSoalEvent extends TaskEvent {
  final String url;
  final String week;

  const DownloadSoalEvent({
    required this.url,
    required this.week,
  });

  @override
  List<Object> get props => [url, week];
}

class UploadJawabanEvent extends TaskEvent {
  final List<PlatformFile> files;

  const UploadJawabanEvent({
    required this.files,
  });

  @override
  List<Object> get props => [files];
}
