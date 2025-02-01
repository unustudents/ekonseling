part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final ProfileStatus status;
  final String error;
  final Map<String, dynamic> data;

  const ProfileState({
    this.status = ProfileStatus.initial,
    this.error = '',
    this.data = const {},
  });

  ProfileState copyWith({
    ProfileStatus? status,
    String? error,
    Map<String, dynamic>? data,
  }) {
    return ProfileState(
      status: status ?? this.status,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }

  @override
  List<Object> get props => [
        status,
        error,
        data,
      ];
}

enum ProfileStatus { initial, loading, success, failure, editMode }
