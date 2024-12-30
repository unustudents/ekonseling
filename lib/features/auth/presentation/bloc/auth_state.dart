part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final String name;
  final String nim;
  final String email;
  final String password;
  final String confirmPassword;
  final bool isLoading;
  final String error;

  const AuthState({
    this.name = '',
    this.nim = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.isLoading = false,
    this.error = '',
  });

  AuthState copyWith({
    String? name,
    String? nim,
    String? email,
    String? password,
    String? confirmPassword,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      name: name ?? this.name,
      nim: nim ?? this.nim,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [name, nim, email, password, confirmPassword, isLoading, error];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final User? user;

  const AuthSuccess({required this.user});

  @override
  List<Object?> get props => [user];
}

class AuthError extends AuthState {
  const AuthError({required String error});

  @override
  List<Object?> get props => [error];
}

class AuthAuthenticated extends AuthState {}

class AuthUnauthenticated extends AuthState {}
