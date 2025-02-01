part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final AuthStatus status;
  final String error;

  const AuthState({
    this.status = AuthStatus.initial,
    this.error = '',
  });

  AuthState copyWith({
    final AuthStatus? status,
    final String? error,
  }) {
    return AuthState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, error];
}

enum AuthStatus {
  initial,
  loading,
  success,
  failure,
  authenticated,
}
