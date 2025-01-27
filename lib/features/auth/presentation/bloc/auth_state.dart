part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final bool isLoading;
  final bool isAuthenticated;
  final String name;
  final String nim;
  final String email;
  final String password;
  final String confirmPassword;
  final String error;

  const AuthState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.name = '',
    this.nim = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.error = '',
  });

  // factory AuthState.initial() {
  //   return const AuthState(
  //     isLoading: false,
  //     isAuthenticated: false,
  //     name: '',
  //     nim: '',
  //     email: '',
  //     password: '',
  //     confirmPassword: '',
  //     error: '',
  //   );
  // }

  AuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    String? name,
    String? nim,
    String? email,
    String? password,
    String? confirmPassword,
    String? error,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      name: name ?? this.name,
      nim: nim ?? this.nim,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isAuthenticated,
        name,
        nim,
        email,
        password,
        confirmPassword,
        error,
      ];
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
