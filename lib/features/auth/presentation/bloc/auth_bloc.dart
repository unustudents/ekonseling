import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:crypto/crypto.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../supabase_config.dart';
import '../../data/models/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // final FirebaseAuth _firebaseAuth;

  AuthBloc() : super(AuthInitial()) {
    // : _firebaseAuth = FirebaseAuth.instance,
    on<NameChanged>(_onNameChanged);
    on<NIMChanged>(_onNIMChanged);
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<ConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<SubmitRegistration>(_onSubmitRegistration);
    on<SubmitSignIn>(_onSubmitSignIn);
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
    emit(state.copyWith(password: event.password));
  }

  void _onConfirmPasswordChanged(ConfirmPasswordChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(confirmPassword: event.confirmPassword));
  }

  Future<void> _onSubmitRegistration(SubmitRegistration event, Emitter<AuthState> emit) async {
    if (!formKey.currentState!.validate()) {
      emit(AuthFailure(error: 'Form tidak valid.'));
      return;
    }
    emit(AuthLoading());
    try {
      // ENCRYPT PASSWORD
      String hashedPassword = hashPassword(event.password);

      // REGISTRATIONS USER TO DATABASE
      AuthResponse authResponse = await SupabaseConfig.client.auth.signUp(password: hashedPassword, email: 'user${event.nis}@ekonseling.dummy');
      if (authResponse.user == null) emit(AuthFailure(error: "Pendaftaran gagal"));

      // UPLOAD DATA TO DATABASE
      await SupabaseConfig.client.from('users').insert(UserModel(name: event.name, nis: event.nis, passHash: event.password).toJson());

      emit(AuthSuccess(user: authResponse.user));
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }

  Future<void> _onSubmitSignIn(SubmitSignIn event, Emitter<AuthState> emit) async {
    if (!formKey.currentState!.validate()) {
      emit(AuthFailure(error: 'Form tidak valid.'));
      return;
    }
    try {
      // ENCRYPT PASSWORD
      String hashedPassword = hashPassword(event.password);

      // QUERY USER FROM DATABASE TO GET EMAIL
      final Map<String, dynamic>? response = await SupabaseConfig.client.from('users').select('email').eq('nis', event.nis).maybeSingle();
      if (response!.isEmpty) emit(AuthFailure(error: 'NIS tidak ditemukan'));

      // SIGN IN USER
      final authResponse = await SupabaseConfig.client.auth.signInWithPassword(email: response['email'], password: hashedPassword);
      if (authResponse.session != null) {
        emit(AuthSuccess(user: authResponse.user));
      } else {
        emit(AuthFailure(error: 'Login gagal, maaf akun tidak ditemukan'));
      }
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
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
    if (!RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email)) return 'Format email tidak valid';
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
