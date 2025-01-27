part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final bool isLoading;
  final bool isAuthenticated;
  final bool isSuccess;
  final String name;
  final String nim;
  final String email;
  final String password;
  final String confirmPassword;
  final String error;

  const AuthState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.isSuccess = false,
    this.name = '',
    this.nim = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.error = '',
  });

  AuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    bool? isSuccess,
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
      isSuccess: isSuccess ?? this.isSuccess,
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
        isSuccess,
        name,
        nim,
        email,
        password,
        confirmPassword,
        error,
      ];
}
