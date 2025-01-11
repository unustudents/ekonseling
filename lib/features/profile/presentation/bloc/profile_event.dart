part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ToggleEditModeEvent extends ProfileEvent {}

class SignOutRequestedEvent extends ProfileEvent {}

class EditProfileEvent extends ProfileEvent {
  final Map<String, dynamic> dataEdit;

  const EditProfileEvent(this.dataEdit);

  @override
  List<Object> get props => [dataEdit];
}

class LoadProfileEvent extends ProfileEvent {}

class TogglePasswordVisibilityEvent extends ProfileEvent {
  final int showPassword;

  const TogglePasswordVisibilityEvent({required this.showPassword});

  @override
  List<Object> get props => [showPassword];
}
