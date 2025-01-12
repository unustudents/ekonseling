import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

import '../../../../supabase_config.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    on<TaskLoadEvent>(_onLoadTask);
    on<UploadTaskEvent>(_onUploadTask);
    add(TaskLoadEvent());
  }

  // @override
  // onChange(change) {
  //   super.onChange(change);
  //   print(change);
  // }

  // FUNCTION - LOAD TASK
  Future<void> _onLoadTask(TaskLoadEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    // pengujian
    try {
      // load data minggu
      List<Map<String, dynamic>> response = await SupabaseConfig.client.from('tasks').select('week').order('created_at');
      // jika response tidak ada isinya
      if (response.isEmpty) return emit(TaskEmpty());
      // jika response ada isinya
      if (response.isNotEmpty) return emit(TaskLoaded(tasks: response));
      emit(TaskLoading(false));
    } catch (e) {
      emit(TaskError(message: '$e'));
    }
  }

  Future<void> _onUploadTask(UploadTaskEvent event, Emitter<TaskState> emit) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'jpeg', 'png'],
    );
    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();
      print(files);
    } else {
      // User canceled the picker
    }
  }
}
