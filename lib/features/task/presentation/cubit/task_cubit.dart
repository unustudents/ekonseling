import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as path;

import '../../../../core/path_directory.dart';
import '../../../../core/permission.dart';
import '../../../../supabase_config.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  // Variable
  final CheckPermission checkPermission;
  CancelToken forCancelToken = CancelToken();
  final PathDirectory getPathFile;
  late String filePath;
  late String fileName;

  TaskCubit(this.checkPermission, this.getPathFile, String url) : super(TaskState()) {
    _onLoadTask();
    onCheckPermission();
    onFileExist(url);
  }

  // TASK ---------------------------------------------------
  Future<void> _onLoadTask() async {
    emit(state.copyWith(isLoading: true));
    try {
      // Mengambil data minggu / week
      final PostgrestList response = await SupabaseConfig.client.from('tasks').select('week, soal').order('created_at');
      // Jika response ada isinya
      if (response.isNotEmpty) {
        emit(state.copyWith(week: response));
        return;
      }
    } catch (e) {
      emit(state.copyWith(error: 'Terjadi kesalahan ketika mengambil data'));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  // QUESTION ---------------------------------------------------
  // Future<void> onLoadQuestion({required String weekId}) async {
  //   emit(state.copyWith(isLoading: true));
  //   try {
  //     // Mengambil data soal / question
  //     final PostgrestList response = await SupabaseConfig.client.from('questions').select('question_text').eq('id_task', weekId);
  //     // Jika response tidak ada isinya
  //     if (response.isEmpty) {
  //       emit(state.copyWith(question: [], error: 'Data tidak ditemukan'));
  //       return;
  //     }
  //     // Jika response ada isinya
  //     if (response.isNotEmpty) {
  //       emit(state.copyWith(question: response));
  //       return;
  //     }
  //   } catch (e) {
  //     emit(state.copyWith(error: 'Terjadi kesalahan ketika mengambil data'));
  //   } finally {
  //     emit(state.copyWith(isLoading: false));
  //   }
  // }

  // Cek permission
  Future<void> onCheckPermission() async {
    bool forPermission = await checkPermission.isStoragePermission();
    emit(state.copyWith(isPermission: forPermission));
  }

  // Cek apakah file sudah ada
  Future<void> onFileExist(String url) async {
    String forFileName = path.basename(url);
    String storagePath = await getPathFile.getPath();
    String forFilePath = '$storagePath/$forFileName';
    bool forFileExist = await File(forFilePath).exists();
    emit(state.copyWith(fileName: forFileName, fileExist: forFileExist, filePath: forFilePath));
  }

  // Mendownload soal
  Future<void> onDownloadQuestion({required String url}) async {
    emit(state.copyWith(downloading: true));
    forCancelToken = CancelToken();
    try {
      await Dio().download(
        url,
        state.filePath,
        onReceiveProgress: (count, total) {
          double forProgress = count / total;
          emit(state.copyWith(progress: forProgress));
        },
        cancelToken: forCancelToken,
      );
      emit(state.copyWith(downloading: false, fileExist: true));
    } catch (e) {
      emit(state.copyWith(downloading: false, error: 'Gagal mendownload file, coba lagi !'));
    }
  }

  // Membatalkan download
  void onCancelDownload() {
    forCancelToken.cancel();
    emit(state.copyWith(downloading: false));
    return;
  }

  // Membuka file
  void onOpenFile() {
    OpenFile.open(state.filePath);
    return;
  }

  // Memilih file dari storage
  Future<void> onSelectFile() async {
    FilePickerResult? forResult = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png'],
    );
    if (forResult != null) emit(state.copyWith(fileSelected: forResult.files));
    return;
  }

  // Menghapus file yang dipilih
  void onRemoveFile(PlatformFile file) {
    final List<PlatformFile> updatedFiles = List<PlatformFile>.from(state.fileSelected)..remove(file);
    emit(state.copyWith(fileSelected: updatedFiles));
    return;
  }
}
