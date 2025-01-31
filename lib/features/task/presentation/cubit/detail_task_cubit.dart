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

part 'detail_task_state.dart';

class DetailTaskCubit extends Cubit<DetailTaskState> {
  CancelToken forCancelToken = CancelToken();
  final PathDirectory getPathFile = PathDirectory();
  final CheckPermission checkPermission = CheckPermission();
  late String filePath;
  late String fileName;

  DetailTaskCubit({required String url}) : super(DetailTaskState()) {
    onCheckPermission();
    onFileExist(url);
  }

  // FUNCTION - CHECK PERMISSION
  Future<void> onCheckPermission() async {
    bool forPermission = await checkPermission.isStoragePermission();
    emit(state.copyWith(isPermission: forPermission));
  }

  // FUNCTION - DOWNLOAD FILE
  Future<void> onDownloadQuestion({required String url}) async {
    emit(state.copyWith(isDownloading: true));
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
      emit(state.copyWith(isDownloading: false, isFileExist: true));
    } catch (e) {
      emit(state.copyWith(isDownloading: false, error: 'Gagal mendownload file, coba lagi !'));
    }
  }

  // FUNCTION - BATALKAN DOWNLOAD
  void onCancelDownload() {
    forCancelToken.cancel();
    emit(state.copyWith(isDownloading: false));
    return;
  }

  // FUNCTION - CHECK FILE EXIST
  Future<void> onFileExist(String url) async {
    String forFileName = path.basename(url);
    String storagePath = await getPathFile.getPath();
    String forFilePath = '$storagePath/$forFileName';
    bool forFileExist = await File(forFilePath).exists();
    emit(state.copyWith(fileName: forFileName, isFileExist: forFileExist, filePath: forFilePath));
  }

  // FUNCTION - OPEN FILE
  void onOpenFile() {
    OpenFile.open(state.filePath);
    return;
  }

  // FUNCTION - SELECT FILE
  Future<void> onSelectFile() async {
    FilePickerResult? forResult = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png'],
    );
    if (forResult != null) emit(state.copyWith(fileSelected: forResult.files));
    return;
  }

  // FUNCTION - REMOVE FILE
  void onRemoveFile(PlatformFile file) {
    final List<PlatformFile> updatedFiles = List<PlatformFile>.from(state.fileSelected)..remove(file);
    emit(state.copyWith(fileSelected: updatedFiles));
    return;
  }

  // FUNCTION - UPLOAD FILE
  Future<void> onUploadTask(List<PlatformFile> files) async {
    emit(state.copyWith(isLoading: true));
    try {
      for (var data in files) {
        File forFile = File(data.path!);
        final String forFilePath = 'submissions/${SupabaseConfig.client.auth.currentUser!.id}/${data.name}';
        final String forUploadResponse = await SupabaseConfig.client.storage.from('jawaban-tugas').upload(forFilePath, forFile);
        if (forUploadResponse.isEmpty) {
          emit(state.copyWith(error: 'Gagal mengunggah file'));
          return;
        }
        if (forUploadResponse.contains(forFilePath)) {
          final String forPublicURL = SupabaseConfig.client.storage.from('jawaban-tugas').getPublicUrl(forFilePath);
          await SupabaseConfig.client.from('submissions').insert({
            'id_user': SupabaseConfig.client.auth.currentUser!.id,
            'file_uploaded': forPublicURL,
          });
          emit(state.copyWith(success: 'Berhasil mengunggah ${data.name}'));
          return;
        }
      }
    } catch (e) {
      emit(state.copyWith(error: 'Terjadi kesalahan ketika mengunggah file'));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
}
