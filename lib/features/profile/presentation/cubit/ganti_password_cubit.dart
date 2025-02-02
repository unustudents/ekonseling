import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:crypto/crypto.dart';
import 'package:ekonseling/supabase_config.dart';
import 'package:equatable/equatable.dart';
export 'package:flutter_bloc/flutter_bloc.dart';
part 'ganti_password_state.dart';

class GantiPasswordCubit extends Cubit<GantiPasswordState> {
  GantiPasswordCubit() : super(GantiPasswordState());

  // FUNCTION - UNTUK MEMPERBARUI KATA SANDI
  Future<void> onUpdatePassword({required String currentPassword, required String newPassword}) async {
    emit(state.copyWith(status: GantiPasswordStatus.loading));
    String hashCurrent = hashedPassword(currentPassword);
    String hashNew = hashedPassword(newPassword);
    try {
      final PostgrestMap? passHash = await SupabaseConfig.client.from('users').select('pass_hash').eq('id', SupabaseConfig.client.auth.currentUser!.id).maybeSingle();
      if (passHash == null || passHash.isEmpty) {
        emit(state.copyWith(status: GantiPasswordStatus.failure, msg: "Error ketika memeriksa password"));
        return;
      }
      if (passHash.isNotEmpty) {
        final bool response = passHash.containsValue(hashCurrent);
        if (!response) {
          emit(state.copyWith(status: GantiPasswordStatus.failure, msg: "Password lama tidak sesuai"));
          return;
        }
        if (response) {
          await SupabaseConfig.client.auth.updateUser(UserAttributes(password: hashNew));
          await SupabaseConfig.client.from('users').update({'pass_hash': hashNew}).eq('id', SupabaseConfig.client.auth.currentUser!.id);
          emit(state.copyWith(status: GantiPasswordStatus.success, msg: "Password berhasil diubah"));
        }
      }
    } catch (e) {
      emit(state.copyWith(status: GantiPasswordStatus.failure, msg: "Error ketika mengubah password"));
    }
  }

  // METHOD - UNTUK MENGHASILKAN HASH PASSWORD
  String hashedPassword(String password) {
    return sha256.convert(utf8.encode(password)).toString();
  }
}
