// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'profile_bloc.dart';

@immutable
class ProfileState extends Equatable {
  // untuk masuk mode edit
  final bool isEditMode;

  // untuk loading saat ambil data profile
  final bool isLoading;

  // untuk menampilkan error di profil
  final String error;

  // data profile
  final Map<String, dynamic> data;

  // controller untuk nama dan nis di form profile
  final String nameController;
  final String nisController;

  // untuk obsecure text field password
  final bool showCurrentPassword;
  final bool showNewPassword;
  final bool showConfirmPassword;

  const ProfileState({
    required this.isEditMode,
    required this.isLoading,
    required this.error,
    required this.data,
    required this.nameController,
    required this.nisController,
    required this.showCurrentPassword,
    required this.showNewPassword,
    required this.showConfirmPassword,
  });

  factory ProfileState.initial() {
    return ProfileState(
      isEditMode: false,
      isLoading: false,
      error: '',
      data: {},
      nameController: '',
      nisController: '',
      showCurrentPassword: true,
      showNewPassword: true,
      showConfirmPassword: true,
    );
  }

  ProfileState copyWith({
    bool? isEditMode,
    bool? isLoading,
    String? error,
    Map<String, dynamic>? data,
    String? nameController,
    String? nisController,
    bool? showCurrentPassword,
    bool? showNewPassword,
    bool? showConfirmPassword,
  }) {
    return ProfileState(
      isEditMode: isEditMode ?? this.isEditMode,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
      nameController: nameController ?? this.nameController,
      nisController: nisController ?? this.nisController,
      showCurrentPassword: showCurrentPassword ?? this.showCurrentPassword,
      showNewPassword: showNewPassword ?? this.showNewPassword,
      showConfirmPassword: showConfirmPassword ?? this.showConfirmPassword,
    );
  }

  @override
  List<Object> get props {
    return [
      isEditMode,
      isLoading,
      error,
      data,
      nameController,
      nisController,
      showCurrentPassword,
      showNewPassword,
      showConfirmPassword,
    ];
  }
}
