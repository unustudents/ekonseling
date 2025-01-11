import 'dart:async';

import 'package:bloc/bloc.dart';
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
    add(LoadProfileEvent());
  }

  @override
  void onChange(Change<ProfileState> change) {
    print(change);
    super.onChange(change);
  }

  void _onToggleEditMode(ToggleEditModeEvent event, Emitter<ProfileState> emit) {
    emit(state.copyWith(isEditMode: !state.isEditMode));
  }

  Future<void> _onSignOutRequested(SignOutRequestedEvent event, Emitter<ProfileState> emit) async {
    try {
      await SupabaseConfig.client.auth.signOut();
      // Tambahkan navigasi jika diperlukan
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  void _onEditProfile(EditProfileEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      // Tambahkan kode untuk mengedit profile
      final response = await SupabaseConfig.client
          .from('users')
          .update(event.dataEdit)
          .eq('id', SupabaseConfig.client.auth.currentUser!.id)
          .select('name, nis, profile_url')
          .single();
      if (response.isEmpty) emit(state.copyWith(error: 'Profile tidak ditemukan'));
      if (response.isNotEmpty) emit(state.copyWith(data: response));
    } catch (e) {
      emit(state.copyWith(error: 'Error ketika update profile: $e'));
    } finally {
      emit(state.copyWith(isLoading: false, isEditMode: false));
    }
  }

  Future<void> _onLoadProfile(LoadProfileEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      // Tambahkan kode untuk load profile
      final response =
          await SupabaseConfig.client.from('users').select('name, nis, profile_url').eq('id', SupabaseConfig.client.auth.currentUser!.id).single();
      print(response);
      if (response.isEmpty) emit(state.copyWith(error: 'Profile tidak ditemukan'));
      if (response.isNotEmpty) emit(state.copyWith(data: response));
    } catch (e) {
      emit(state.copyWith(error: 'Error ketika load profile: $e'));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  _onTogglePasswordVisibility(TogglePasswordVisibilityEvent event, Emitter<ProfileState> emit) {
    switch (event.showPassword) {
      case 1:
        emit(state.copyWith(showCurrentPassword: !state.showCurrentPassword));
      case 2:
        emit(state.copyWith(showNewPassword: !state.showNewPassword));
      case 3:
        emit(state.copyWith(showConfirmPassword: !state.showConfirmPassword));
    }
  }
}
