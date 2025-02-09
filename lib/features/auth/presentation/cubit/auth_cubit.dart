import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:crypto/crypto.dart';
import 'package:equatable/equatable.dart';

import '../../../../supabase_config.dart';
import '../../data/models/user_model.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState()) {
    // ketika suatu event di panggil, maka akan memanggil fungsi yang sesuai
    _onAuthCheckRequested();
  }

  @override
  void onChange(Change<AuthState> change) {
    log(change.toString());
    super.onChange(change);
  }

  // CEK SESSION ----------------------------------------------
  // Fungsi untuk mengecek session, apakah user sudah login atau belum
  Future<void> _onAuthCheckRequested() async {
    emit(state.copyWith(status: AuthStatus.loading));
    // Mengecek session user
    final session = SupabaseConfig.client.auth.currentSession;
    // Menunggu 5 detik
    await Future.delayed(const Duration(seconds: 3)); // Simulasi Splash
    // Jika session null, maka user belum login
    if (session == null) {
      emit(state.copyWith(status: AuthStatus.failure));
    } else {
      emit(state.copyWith(status: AuthStatus.authenticated));
    }
  }

  // SIGN UP ----------------------------------------------
  // Fungsi untuk sign up user
  Future<void> onSubmitRegistration({required String password, required String nis, required String name}) async {
    emit(AuthState());
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      // Encrypt password
      String hashedPassword = _hashPassword(password);
      // Mendaftarkan user baru
      await SupabaseConfig.client.auth.signUp(password: hashedPassword, email: 'user$nis@ekonseling.dummy');
      // Jika berhasil mendaftar, maka simpan data user ke database
      await SupabaseConfig.client.from('users').insert(UserModel(name: name, email: 'user$nis@ekonseling.dummy', nis: nis, passHash: hashedPassword).toJson());
      // Jika berhasil, maka ubah state menjadi isSuccess: true
      emit(state.copyWith(status: AuthStatus.success));
      return;
    } on AuthException catch (_) {
      emit(state.copyWith(status: AuthStatus.initial, error: 'Error ketika mendaftar'));
      return;
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.initial, error: 'Sepertinya terjadi kesalahan'));
      return;
    }
  }

  // SIGN IN ----------------------------------------------
  // Fungsi untuk sign in user
  Future<void> onSubmitSignIn({required String password, required String nis}) async {
    emit(AuthState());
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      // encrypt password
      String hashedPassword = _hashPassword(password);
      // query mengambil email berdasarkan nis
      final Map<String, dynamic>? response = await SupabaseConfig.client.from('users').select('email').eq('nis', nis).maybeSingle();
      // cek apakah response kosong atau tidak ditemukan
      if (response == null || response.isEmpty) {
        emit(state.copyWith(status: AuthStatus.initial, error: 'NIS tidak ditemukan'));
        return;
      }
      // sign in user
      final authResponse = await SupabaseConfig.client.auth.signInWithPassword(email: response['email'], password: hashedPassword);
      // cek apakah session ada
      if (authResponse.session != null) {
        emit(state.copyWith(status: AuthStatus.authenticated));
        return;
      } else {
        emit(state.copyWith(status: AuthStatus.initial, error: 'Login gagal, maaf akun tidak ditemukan'));
        return;
      }
    } catch (e) {
      // Penanganan error lainnya (misalnya kesalahan jaringan)
      emit(state.copyWith(status: AuthStatus.initial, error: 'Sepertinya anda belum registrasi atau terjadi kesalahan lainnya'));
      return;
    }
  }

  // METHOD ----------------------------------------------
  // Fungsi untuk hash password
  String _hashPassword(String password) {
    //var bytes = utf8.encode(password); // Mengkonversi password ke bytes
    //var digest = sha256.convert(bytes); // Meng-hash password
    //return digest.toString();// Mengembalikan hasil hash dalam bentuk string
    return sha256.convert(utf8.encode(password)).toString();
  }
}
