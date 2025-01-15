import 'dart:async';
// import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

// import 'package:file_picker/file_picker.dart';

import '../../../../supabase_config.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskState.initial()) {
    on<TaskLoadEvent>(_onLoadTask);
    on<UploadFileEvent>(_onUploadTask);
    add(TaskLoadEvent());
  }

  @override
  onChange(change) {
    print(change);
    super.onChange(change);
  }

  // FUNCTION - LOAD TASK
  Future<void> _onLoadTask(TaskLoadEvent event, Emitter<TaskState> emit) async {
    emit(state.copyWith(isLoading: true));
    print(SupabaseConfig.client.auth.currentUser!.id);
    // pengujian
    try {
      // load data minggu
      List<Map<String, dynamic>> response = await SupabaseConfig.client
          .from('tasks')
          .select('week')
          .order('created_at');
      // jika response tidak ada isinya
      if (response.isEmpty) {
        emit(state.copyWith(error: 'Data tidak ditemukan'));
        return;
      }
      // jika response ada isinya
      if (response.isNotEmpty) {
        emit(state.copyWith(week: response));
        return;
      }
    } catch (e) {
      emit(state.copyWith(error: 'Terjadi kesalahan : $e'));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onUploadTask(
      UploadFileEvent event, Emitter<TaskState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      for (var file in event.files) {
        final fileBytes = file.bytes;
        final filePath =
            '/submissions/${SupabaseConfig.client.auth.currentUser!.id}/${file.name}';
        // mengunggah file ke storage
        final uploadResponse = await SupabaseConfig.client.storage
            .from('jawaban-tugas')
            .uploadBinary(filePath, fileBytes!);
        // jika upload gagal
        if (uploadResponse. != null) {
          emit(state.copyWith(error: 'Gagal mengunggah file'));
          return;
        }
        final String fullPath =
            await SupabaseConfig.client.storage.from('jawaban-tugas').upload(
                  'public/${file.path.split('/').last}',
                  file,
                  fileOptions:
                      const FileOptions(cacheControl: '3600', upsert: false),
                );
      }
    } catch (e) {
      emit(state.copyWith(error: 'Terjadi kesalahan : $e'));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
    // FilePickerResult? result = await FilePicker.platform.pickFiles(
    //   allowMultiple: true,
    //   type: FileType.custom,
    //   allowedExtensions: ['jpg', 'pdf', 'jpeg', 'png'],
    // );
    // if (result != null) {
    // List<File> files = result.paths.map((path) => File(path!)).toList();
    // print(files);
    // final String fullPath = await SupabaseConfig.client.storage.from('avatars').upload(
    //       'public/avatar1.png',
    //       files,
    //       fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
    //     );
    // } else {
    //   // User canceled the picker
    // }
  }
}
