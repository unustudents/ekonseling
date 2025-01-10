import 'dart:math';

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
}
