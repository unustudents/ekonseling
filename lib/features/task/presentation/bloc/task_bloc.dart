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
  TaskBloc() : super(TaskState.initial()) {
    on<LoadWeekEvent>(_onLoadTask);
    // on<LoadQuestionsEvent>(_onLoadQuestion);
    on<DownloadSoalEvent>(_onDownloadTask);
    on<UploadJawabanEvent>(_onUploadTask);
    add(LoadWeekEvent());
  }

  @override
  onChange(change) {
    print(change);
    super.onChange(change);
  }

  // FUNCTION - LOAD TASK
  Future<void> _onLoadTask(LoadWeekEvent event, Emitter<TaskState> emit) async {
    emit(state.copyWith(isLoading: true));
    // pengujian
    try {
      // load data minggu
      List<Map<String, dynamic>> response = await SupabaseConfig.client
          .from('tasks')
          .select('week, soal')
          .order('created_at');
      // jika response tidak ada isinya
      // if (response.isEmpty) {
      //   emit(state.copyWith(error: 'Data tidak ditemukan'));
      //   return;
      // }
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

  // FUNCTION - LOAD QUESTION
  Future<void> _onLoadQuestion(
      LoadQuestionsEvent event, Emitter<TaskState> emit) async {
    emit(state.copyWith(isLoading: true));
    print('Masuk Load Question');
    try {
      // load data soal
      final List<Map<String, dynamic>> response = await SupabaseConfig.client
          .from('questions')
          .select('question_text')
          .eq('id_task', event.weekId);
      // jika response tidak ada isinya
      if (response.isEmpty) {
        print('Tidak ada respon');
        emit(state.copyWith(error: 'Data tidak ditemukan', question: []));
        return;
      }
      // jika response ada isinya
      if (response.isNotEmpty) {
        print('response = $response');
        emit(state.copyWith(question: response));
        return;
      }
    } catch (e) {
      emit(state.copyWith(error: 'Terjadi kesalahan : $e'));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  // FUNCTION - DOWNLOAD FILE
  _onDownloadTask(DownloadSoalEvent event, Emitter<TaskState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      // download soal dengan tipe data Uint8List
      final response = await SupabaseConfig.client.storage
          .from('jawaban-tugas')
          .download(event.url);

      // print('response = $response');
      // print('response byte = $response');
      if (response.isEmpty) {
        emit(state.copyWith(isAlert: 'Data tidak ditemukan'));
        return;
      }

      // Tampilkan dialog untuk memilih lokasi penyimpanan
      if (response.isNotEmpty) {
        final savePath = await FilePicker.platform.saveFile(
          dialogTitle: 'Simpan File Sebagai',
          fileName: event.url.split('/').last,
        );
        if (savePath == null) {
          emit(state.copyWith(error: 'Proses penyimpanan dibatalkan'));
          return;
        }
        // Simpan file di lokasi yang dipilih pengguna
        final file = File(savePath);
        await file.writeAsBytes(response);
      }
      // jika response tidak ada isinya
      // if (response.isEmpty) {
      //   emit(state.copyWith(error: 'Data tidak ditemukan'));
      //   return;
      // }
      // // jika response ada isinya
      // if (response.isNotEmpty) {
      //   emit(state.copyWith(question: response));
      //   return;
      // }
    } catch (e) {
      emit(state.copyWith(error: 'Terjadi kesalahan : $e'));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  // FUNCTION - UPLOAD FILE
  Future<void> _onUploadTask(
      UploadJawabanEvent event, Emitter<TaskState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      // perulangan karena menggunakan multiple file
      for (var file in event.files) {
        // mengambil bytes file
        final fileBytes = file.bytes;
        // membuat path file ke folder submissions/id_user/nama_file
        final filePath =
            '/submissions/${SupabaseConfig.client.auth.currentUser!.id}/${file.name}';
        // mengunggah file ke storage
        final uploadResponse = await SupabaseConfig.client.storage
            .from('jawaban-tugas')
            .uploadBinary(filePath, fileBytes!);
        // jika respon upload kosong / tidak sama denga filePath / gagal
        if (uploadResponse.isEmpty) {
          emit(state.copyWith(error: 'Gagal mengunggah file'));
          return;
        }
        // jika respon upload sama dengan filePath
        if (uploadResponse.contains(filePath)) {
          // mengambil url file yang diunggah
          final publicURL = SupabaseConfig.client.storage
              .from('jawaban-tugas')
              .getPublicUrl(filePath);
          // menyimpan url file ke database
          final response =
              await SupabaseConfig.client.from('submissions').insert([
            {
              'id_user': SupabaseConfig.client.auth.currentUser!.id,
              'file_uploaded': publicURL,
              // 'id_question': event.taskId,
            }
          ]);
          emit(state.copyWith(successUpload: 'Sukses mengunggah ${file.name}'));
          return;
        }
        // final String fullPath =
        //     await SupabaseConfig.client.storage.from('jawaban-tugas').upload(
        //           'public/${file.path.split('/').last}',
        //           file,
        //           fileOptions:
        //               const FileOptions(cacheControl: '3600', upsert: false),
        //         );
      }
    } catch (e) {
      emit(state.copyWith(error: 'Terjadi kesalahan : $e'));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  buat() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'jpeg', 'png'],
    );
    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();
      print(files);
      // final String fullPath = await SupabaseConfig.client.storage
      //     .from('avatars')
      //     .upload(
      //       'public/avatar1.png',
      //       files,
      //       fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
      //     );
    } else {
      // User canceled the picker
    }
  }
}
