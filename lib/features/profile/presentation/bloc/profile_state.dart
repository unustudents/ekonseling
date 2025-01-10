part of 'profile_bloc.dart';

@immutable
class ProfileState extends Equatable {
  final bool isEditMode;

  const ProfileState({
    required this.isEditMode,
  });

  factory ProfileState.initial() {
    return ProfileState(
      isEditMode: false,
    );
  }

  ProfileState copyWith({
    final bool? isEditMode,
  }) {
    return ProfileState(
      isEditMode: isEditMode ?? this.isEditMode,
    );
  }

  @override
  List<Object> get props => [
        isEditMode,
      ];
}
