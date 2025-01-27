import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:crypto/crypto.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../supabase_config.dart';
import '../../data/models/user_model.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState()) {
    // ketika suatu event di panggil, maka akan memanggil fungsi yang sesuai
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<SubmitSignIn>(_onSubmitSignIn);
    on<NameChanged>(_onNameChanged);
    on<NIMChanged>(_onNIMChanged);
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<ConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<SubmitRegistration>(_onSubmitRegistration);
    // event berikut akan dijalankan ketika bloc di inisialisasi
    add(AuthCheckRequested());
  }

  @override
  onChange(change) {
    print(change);
    super.onChange(change);
  }

  // CEK SESSION ----------------------------------------------
  // Fungsi untuk mengecek session, apakah user sudah login atau belum
  Future<void> _onAuthCheckRequested(AuthCheckRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true));
    // Mengecek session user
    final session = SupabaseConfig.client.auth.currentSession;
    // Menunggu 5 detik
    await Future.delayed(const Duration(seconds: 5)); // Simulasi Splash
    // Jika session null, maka user belum login
    if (session == null) {
      emit(state.copyWith(isAuthenticated: false));
    } else {
      emit(state.copyWith(isAuthenticated: true));
    }
    emit(state.copyWith(isLoading: false));
  }

  // SIGN UP ----------------------------------------------

  // SIGN IN ----------------------------------------------
  // Fungsi untuk sign in user
  Future<void> _onSubmitSignIn(SubmitSignIn event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      // encrypt password
      String hashedPassword = hashPassword(event.password);
      // query mengambil email berdasarkan nis
      final Map<String, dynamic>? response = await SupabaseConfig.client.from('users').select('email').eq('nis', event.nis).maybeSingle();
      // cek apakah response kosong atau tidak ditemukan
      if (response == null || response.isEmpty) {
        emit(state.copyWith(isLoading: false, error: 'NIS tidak ditemukan'));
        return;
      }
      // sign in user
      final authResponse = await SupabaseConfig.client.auth.signInWithPassword(email: response['email'], password: hashedPassword);
      // cek apakah session ada
      if (authResponse.session != null) {
        emit(state.copyWith(isLoading: false, isAuthenticated: true));
        return;
      } else {
        emit(state.copyWith(isLoading: false, error: 'Login gagal, maaf akun tidak ditemukan'));
        return;
      }
    } on AuthException catch (e) {
      // Penanganan khusus jika terjadi error pada Auth
      emit(state.copyWith(isLoading: false, error: 'Error autentikasi: ${e.message}'));
      return;
    } catch (e) {
      // Penanganan error lainnya (misalnya kesalahan jaringan)
      emit(state.copyWith(isLoading: false, error: 'Sepertinya anda belum registrasi atau terjadi kesalahan lainnya'));
      return;
    }
  }

  final formKey = GlobalKey<FormState>();

  void _onNameChanged(NameChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(name: event.name));
  }

  void _onNIMChanged(NIMChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(nim: event.nim));
  }

  void _onEmailChanged(EmailChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<AuthState> emit) {
    validatePassword(event.password);
    emit(state.copyWith(password: event.password));
  }

  void _onConfirmPasswordChanged(ConfirmPasswordChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(confirmPassword: event.confirmPassword));
  }

  Future<void> _onSubmitRegistration(SubmitRegistration event, Emitter<AuthState> emit) async {
    if (!formKey.currentState!.validate()) {
      emit(AuthError(error: 'Form tidak valid.'));
      return;
    }
    emit(AuthLoading());
    try {
      // ENCRYPT PASSWORD
      String hashedPassword = hashPassword(event.password);

      // REGISTRATIONS USER TO DATABASE
      AuthResponse authResponse = await SupabaseConfig.client.auth.signUp(password: hashedPassword, email: 'user${event.nis}@ekonseling.dummy');
      await SupabaseConfig.client.from('users').insert(UserModel(name: event.name, email: 'user${event.nis}@ekonseling.dummy', nis: event.nis, passHash: hashedPassword).toJson());

      emit(AuthSuccess(user: authResponse.user));
    } catch (e) {
      emit(AuthError(error: e.toString()));
    }
  }

  // Fungsi untuk hash password
  String hashPassword(String password) {
    //var bytes = utf8.encode(password); // Mengkonversi password ke bytes
    //var digest = sha256.convert(bytes); // Meng-hash password
    //return digest.toString();// Mengembalikan hasil hash dalam bentuk string
    return sha256.convert(utf8.encode(password)).toString();
  }

  String? validateName(String? nama) {
    if (nama == null || nama.isEmpty) return 'Nama tidak boleh kosong';
    return null;
  }

  String? validateNIS(String? nis) {
    if (nis == null || nis.isEmpty) return 'NIS tidak boleh kosong';
    return null;
  }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) return 'Email tidak boleh kosong';
    if (!RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(email))
      return 'Format email tidak valid';
    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) return 'Password tidak boleh kosong';
    if (password.length < 6) return 'Password minimal 6 karakter';
    return null;
  }

  String? validateConfirmPassword(String? confirmPassword, String? password) {
    if (confirmPassword == null || confirmPassword.isEmpty) return 'Konfirmasi password tidak boleh kosong';
    if (confirmPassword != password) return 'Konfirmasi password tidak sesuai';
    return null;
  }
}
