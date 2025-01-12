// ignore_for_file: public_member_api_docs, sort_constructors_first
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

class ChangePasswordEvent extends ProfileEvent {
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;

  const ChangePasswordEvent({
    required this.oldPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  @override
  List<Object> get props => [oldPassword, newPassword, confirmPassword];
}
