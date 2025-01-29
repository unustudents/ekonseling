import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../supabase_config.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

part 'detail_task_state.dart';

class DetailTaskCubit extends Cubit<DetailTaskState> {
  DetailTaskCubit() : super(DetailTaskInitial());

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
          emit(state.copyWith(successUpload: 'Berhasil mengunggah ${data.name}'));
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
