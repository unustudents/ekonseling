import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:crypto/crypto.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../supabase_config.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileState.initial()) {
    on<ToggleEditModeEvent>(_onToggleEditMode);
    on<SignOutRequestedEvent>(_onSignOutRequested);
    on<EditProfileEvent>(_onEditProfile);
    on<LoadProfileEvent>(_onLoadProfile);
    on<TogglePasswordVisibilityEvent>(_onTogglePasswordVisibility);
    on<ChangePasswordEvent>(_onUpdatePassword);
    add(LoadProfileEvent());
  }

  // @override
  // void onChange(Change<ProfileState> change) {
  //   super.onChange(change);
  // }

  // FUNCTION - UNTUK MASUK MODE EDIT
  void _onToggleEditMode(event, emit) {
    emit(state.copyWith(isEditMode: !state.isEditMode));
    return;
  }

  Future<void> _onSignOutRequested(event, emit) async {
    try {
      await SupabaseConfig.client.auth.signOut();
      // Tambahkan navigasi jika diperlukan
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  // FUNCTION - UNTUK MENGEDIT PROFILE
  void _onEditProfile(event, emit) async {
    emit(state.copyWith(isLoading: true));
    // langkah pengujian
    try {
      // update data profile sekaligus menarik data setelah di update
      final response = await SupabaseConfig.client
          .from('users')
          .update(event.dataEdit)
          .eq('id', SupabaseConfig.client.auth.currentUser!.id)
          .select('name, nis, profile_url')
          .single();
      // jika respon tidak ada isinya
      if (response.isEmpty) emit(state.copyWith(error: 'Profile tidak ditemukan'));
      // jika respon ada isinya
      if (response.isNotEmpty) emit(state.copyWith(data: response));
    } catch (e) {
      emit(state.copyWith(error: 'Error ketika update profile: $e'));
    } finally {
      emit(state.copyWith(isLoading: false, isEditMode: false));
    }
  }

  // FUNCTION - UNTUK MENGUNDUH DATA PROFILE
  Future<void> _onLoadProfile(event, emit) async {
    emit(state.copyWith(isLoading: true));
    // langkah pengujian
    try {
      // tarik data profile
      final response =
          await SupabaseConfig.client.from('users').select('name, nis, profile_url').eq('id', SupabaseConfig.client.auth.currentUser!.id).single();
      // jika respon tidak ada isinya
      if (response.isEmpty) emit(state.copyWith(error: 'Profile tidak ditemukan'));
      // jika respon ada isinya
      if (response.isNotEmpty) emit(state.copyWith(data: response));
    } catch (e) {
      emit(state.copyWith(error: 'Error ketika load profile: $e'));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  // FUNCTION - UNTUK MENAMPILKAN PASSWORD
  _onTogglePasswordVisibility(event, emit) {
    switch (event.showPassword) {
      case 1:
        return emit(state.copyWith(showCurrentPassword: !state.showCurrentPassword));
      case 2:
        return emit(state.copyWith(showNewPassword: !state.showNewPassword));
      case 3:
        return emit(state.copyWith(showConfirmPassword: !state.showConfirmPassword));
    }
  }

  // FUNCTION - UNTUK MEMPERBARUI PASSWORD
  void _onUpdatePassword(event, emit) async {
    emit(state.copyWith(isLoading: true));

    // validasi form password
    if (event.newPassword != event.confirmPassword) {
      emit(state.copyWith(errorForSnackbar: 'Password konfirmasi tidak sama', isLoading: false));
      return;
    }
    if (event.oldPassword == event.newPassword) {
      emit(state.copyWith(errorForSnackbar: 'Password baru tidak boleh sama dengan password lama', isLoading: false));
      return;
    }

    // enkripsi password lama & baru
    String hashedOldPassword = sha256.convert(utf8.encode(event.oldPassword)).toString();
    String hashedNewPassword = sha256.convert(utf8.encode(event.newPassword)).toString();

    // langkah pengujian
    try {
      // tarik data pass_hass atau password dari database
      Map<String, dynamic>? passHass =
          await SupabaseConfig.client.from('users').select('pass_hash').eq('id', SupabaseConfig.client.auth.currentUser!.id).maybeSingle();

      // jika pass_hass tidak ada isinya
      if (passHass == null || passHass.isEmpty) emit(state.copyWith(error: 'Error ketika load password: $passHass'));

      // jika pass_hass ada isinya
      if (passHass!.isNotEmpty) {
        // cek password lama apakah sama
        bool response = passHass.containsValue(hashedOldPassword);
        // jika password lama tidak sama
        if (!response) emit(state.copyWith(errorForSnackbar: 'Password lama salah'));
        // jika password lama sama
        if (response) {
          // update password di auth & database
          await SupabaseConfig.client.auth.updateUser(UserAttributes(password: hashedNewPassword));
          await SupabaseConfig.client.from('users').update({'pass_hash': hashedNewPassword}).eq('id', SupabaseConfig.client.auth.currentUser!.id);
          emit(state.copyWith(successChangePassword: 'Password berhasil diubah'));
        }
      }
    } catch (e) {
      emit(state.copyWith(error: 'Error ketika update password: $e'));
    } finally {
      emit(state.copyWith(isLoading: false, errorForSnackbar: ''));
    }
  }
}
