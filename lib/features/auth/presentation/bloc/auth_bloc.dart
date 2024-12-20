import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _firebaseAuth;

  AuthBloc()
      : _firebaseAuth = FirebaseAuth.instance,
        super(AuthInitial()) {
    on<NameChanged>(_onNameChanged);
    on<NIMChanged>(_onNIMChanged);
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<ConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<SubmitRegistration>(_onSubmitRegistration);
    on<SubmitSignIn>(_onSubmitSignIn);
  }

  final formKey = GlobalKey<FormState>();

  void _onNameChanged(NameChanged event, Emitter<AuthState> emit) => emit(state.copyWith(name: event.name));

  void _onNIMChanged(NIMChanged event, Emitter<AuthState> emit) => emit(state.copyWith(nim: event.nim));

  void _onEmailChanged(EmailChanged event, Emitter<AuthState> emit) => emit(state.copyWith(email: event.email));

  void _onPasswordChanged(PasswordChanged event, Emitter<AuthState> emit) => emit(state.copyWith(password: event.password));

  void _onConfirmPasswordChanged(ConfirmPasswordChanged event, Emitter<AuthState> emit) =>
      emit(state.copyWith(confirmPassword: event.confirmPassword));

  Future<void> _onSubmitRegistration(SubmitRegistration event, Emitter<AuthState> emit) async {
    if (!formKey.currentState!.validate()) {
      emit(AuthFailure(error: 'Form tidak valid.'));
      return;
    }
    try {
      emit(AuthLoading());

      // Firebase Authentication untuk registrasi user baru
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );

      emit(AuthSuccess(user: userCredential.user));
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }

  Future<void> _onSubmitSignIn(SubmitSignIn event, Emitter<AuthState> emit) async {
    if (!formKey.currentState!.validate()) {
      emit(AuthFailure(error: 'Form tidak valid.'));
      return;
    }

    // try {
    //   emit(AuthLoading());

    //   // Firebase Authentication untuk login user
    //   final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
    //     email: state.email,
    //     password: state.password,
    //   );

    //   emit(AuthSuccess(user: userCredential.user));
    // } catch (e) {
    //   emit(AuthFailure(error: e.toString()));
    // }
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
