part of 'auth_bloc.dart';
// export 'package:flutter_bloc/flutter_bloc.dart';

abstract class AuthEvent {}

class NameChanged extends AuthEvent {
  final String name;

  NameChanged({required this.name});
}

class NIMChanged extends AuthEvent {
  final String nim;

  NIMChanged({required this.nim});
}

class EmailChanged extends AuthEvent {
  final String email;

  EmailChanged({required this.email});
}

class PasswordChanged extends AuthEvent {
  final String password;

  PasswordChanged({required this.password});
}

class ConfirmPasswordChanged extends AuthEvent {
  final String confirmPassword;

  ConfirmPasswordChanged({required this.confirmPassword});
}

class SubmitRegistration extends AuthEvent {
  final String name;
  final String nis;
  final String password;

  SubmitRegistration({required this.name, required this.nis, required this.password});
}

class SubmitSignIn extends AuthEvent {
  final String nis;
  final String password;

  SubmitSignIn({required this.nis, required this.password});
}
