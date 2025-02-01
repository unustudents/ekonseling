import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../supabase_config.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState()) {
    _onLoadProfile();
  }

  // FUNCTION - UNTUK MENGAMBIL DATA PROFILE
  Future<void> _onLoadProfile() async {
    emit(state.copyWith(status: ProfileStatus.loading));
    try {
      final PostgrestMap response = await SupabaseConfig.client.from('users').select('name, nis, profile_url').eq('id', SupabaseConfig.client.auth.currentUser!.id).single();
      if (response.isEmpty) {
        emit(state.copyWith(status: ProfileStatus.initial, error: 'Profile tidak ditemukan'));
        return;
      }
      if (response.isNotEmpty) {
        emit(state.copyWith(status: ProfileStatus.initial, data: response));
        return;
      }
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(error: 'Terjadi kesalahan'));
    }
  }

  // FUNCTION - UNTUK MEMPERBARUI PROFILE
  Future<void> onUpdateProfile(Map<String, dynamic> data) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    try {
      final PostgrestMap response = await SupabaseConfig.client.from('users').update(data).eq('id', SupabaseConfig.client.auth.currentUser!.id).select('name, nis, profile_url').single();
      if (response.isEmpty) {
        emit(state.copyWith(status: ProfileStatus.initial, error: 'Profile tidak ditemukan'));
        return;
      }
      if (response.isNotEmpty) {
        emit(state.copyWith(status: ProfileStatus.success, data: response));
        return;
      }
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(status: ProfileStatus.failure, error: 'Terjadi kesalahan'));
    }
  }

  // FUNCTION - UNTUK KELUAR AKUN
  Future<void> onSignOut() async => await SupabaseConfig.client.auth.signOut();
}
