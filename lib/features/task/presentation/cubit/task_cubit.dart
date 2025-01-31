import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/permission.dart';
import '../../../../supabase_config.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  // Variable
  final CheckPermission checkPermission = CheckPermission();

  TaskCubit() : super(TaskState()) {
    _onLoadTask();
    onCheckPermission();
  }

  // FUNCTION - LOAD TASK
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

  // FUNCTION - CHECK PERMISSION
  Future<void> onCheckPermission() async {
    bool forPermission = await checkPermission.isStoragePermission();
    emit(state.copyWith(isPermission: forPermission));
  }
}
