import 'dart:developer';
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
  // variabel
  CancelToken forCancelToken = CancelToken();
  final PathDirectory getPathFile = PathDirectory();
  final CheckPermission checkPermission = CheckPermission();
  late String filePath;
  late String fileName;

  DetailTaskCubit({required String url}) : super(DetailTaskState()) {
    onCheckPermission();
    onFileExist(url);
  }

  @override
  onChange(Change<DetailTaskState> change) {
    log(change.toString());
    super.onChange(change);
  }

  // FUNCTION - CHECK PERMISSION
  Future<void> onCheckPermission() async {
    // cek perizinan
    bool forPermission = await checkPermission.isStoragePermission();
    // perbarui state
    emit(state.copyWith(isPermission: forPermission));
  }

  // FUNCTION - DOWNLOAD FILE
  Future<void> onDownloadQuestion({required String url}) async {
    // cek perizinan dulu
    if (!state.isPermission) {
      await onCheckPermission();
      emit(state.copyWith(status: DetailTaskStatus.error, msg: 'Izin akses penyimpanan tidak diizinkan'));
      return;
    }
    // perbarui state -- status downloading
    emit(state.copyWith(status: DetailTaskStatus.downloading));
    // buat cancel token
    forCancelToken = CancelToken();
    // coba download file
    try {
      // menunggu download file
      await Dio().download(
        url, // url file
        state.filePath, // path penyimpanan
        onReceiveProgress: (count, total) {
          // hitung progress
          double forProgress = count / total;
          // perbarui state -- progress persentase download
          emit(state.copyWith(progress: forProgress));
        },
        // cancel token
        cancelToken: forCancelToken,
      );
      // perbarui state -- status sukses
      emit(state.copyWith(status: DetailTaskStatus.success, isFileExist: true, msg: 'Berhasil mengunduh file'));
    } catch (e) {
      // perbarui state -- status error
      emit(state.copyWith(status: DetailTaskStatus.error, msg: 'Gagal mengunduh file, coba lagi !'));
    }
  }

  // FUNCTION - BATALKAN DOWNLOAD
  void onCancelDownload() {
    // batal download
    forCancelToken.cancel();
    // perbarui state -- batalkan download
    emit(state.copyWith(status: DetailTaskStatus.initial));
    return;
  }

  // FUNCTION - CHECK FILE EXIST
  Future<void> onFileExist(String url) async {
    // mengambil nama file dari url
    String forFileName = path.basename(Uri.parse(url).path);
    // mendapatkan path tempat penyimpanan
    String storagePath = await getPathFile.getPath();
    // menggabungkan path dengan nama file
    String forFilePath = '$storagePath/$forFileName';
    // cek apakah file sudah ada atau belum berdasarkan path yang sudah digabung
    bool forFileExist = await File(forFilePath).exists();
    // jika function ini dipanggil dari luar, maka tidak akan mengembalikan nilai
    if (!isClosed) {
      emit(state.copyWith(fileName: forFileName, isFileExist: forFileExist, filePath: forFilePath));
    }
  }

  // FUNCTION - OPEN FILE
  void onOpenFile() {
    // buka file
    OpenFile.open(state.filePath);
    return;
  }

  // FUNCTION - SELECT FILE
  Future<void> onSelectFile() async {
    // pilih file
    FilePickerResult? forResult = await FilePicker.platform.pickFiles(
      allowMultiple: true, // memilih banyak file
      type: FileType.custom, // tipe file yang diizinkan
      allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png'], // ekstensi file yang diizinkan
    );
    // jika forResult tidak kosong / null, perbarui state
    if (forResult != null) emit(state.copyWith(fileSelected: forResult.files));
    return;
  }

  // FUNCTION - REMOVE FILE SELECTED
  void onRemoveFile(PlatformFile file) {
    // hapus file
    final List<PlatformFile> updatedFiles = List<PlatformFile>.from(state.fileSelected)..remove(file);
    // perbarui state
    emit(state.copyWith(fileSelected: updatedFiles));
    return;
  }

  // FUNCTION - UPLOAD FILE
  Future<void> onUploadTask(List<PlatformFile> files) async {
    // emit(state.copyWith(isLoading: true));
    emit(state.copyWith(status: DetailTaskStatus.loading));
    try {
      for (var data in files) {
        File forFile = File(data.path!);
        final String forFilePath = 'submissions/${SupabaseConfig.client.auth.currentUser!.id}/${data.name}';
        final String forUploadResponse = await SupabaseConfig.client.storage.from('jawaban-tugas').upload(forFilePath, forFile);
        if (forUploadResponse.isEmpty) {
          // emit(state.copyWith(error: 'Gagal mengunggah file'));
          emit(state.copyWith(status: DetailTaskStatus.error, msg: 'Gagal mengunggah file'));
          return;
        }
        if (forUploadResponse.contains(forFilePath)) {
          final String forPublicURL = SupabaseConfig.client.storage.from('jawaban-tugas').getPublicUrl(forFilePath);
          await SupabaseConfig.client.from('submissions').insert({
            'id_user': SupabaseConfig.client.auth.currentUser!.id,
            'file_uploaded': forPublicURL,
          });
          // emit(state.copyWith(success: 'Berhasil mengunggah ${data.name}'));
          emit(state.copyWith(status: DetailTaskStatus.success, msg: 'Berhasil mengunggah ${data.name}'));
          return;
        }
      }
    } catch (e) {
      // emit(state.copyWith(error: 'Terjadi kesalahan ketika mengunggah file'));
      emit(state.copyWith(status: DetailTaskStatus.error, msg: 'Terjadi kesalahan ketika mengunggah file'));
    } finally {
      // emit(state.copyWith(isLoading: false));
    }
  }

  // FUNCTION - DELETE FILE SOAL
  void onDeleteFileSoal() {
    // hapus file soal
    File(state.filePath).delete();
    // perbarui state
    emit(state.copyWith(status: DetailTaskStatus.success, isFileExist: false, msg: 'Berhasil menghapus file'));
    return;
  }
}
