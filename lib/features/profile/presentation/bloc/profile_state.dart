// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_bloc.dart';

@immutable
class ProfileState extends Equatable {
  // untuk masuk mode edit di profile
  final bool isEditMode;

  // untuk loading
  final bool isLoading;

  // untuk menampilkan error
  final String error;
  final String errorForSnackbar;

  // data profile
  final Map<String, dynamic> data;

  // controller untuk nama dan nis di form profile
  final String nameController;
  final String nisController;

  // untuk obsecure text field password
  final bool showCurrentPassword;
  final bool showNewPassword;
  final bool showConfirmPassword;

  // untuk info berhasil ganti password
  final String successChangePassword;

  const ProfileState({
    required this.isEditMode,
    required this.isLoading,
    required this.error,
    required this.errorForSnackbar,
    required this.data,
    required this.nameController,
    required this.nisController,
    required this.showCurrentPassword,
    required this.showNewPassword,
    required this.showConfirmPassword,
    required this.successChangePassword,
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
      successChangePassword: '',
      errorForSnackbar: '',
    );
  }

  ProfileState copyWith({
    bool? isEditMode,
    bool? isLoading,
    String? error,
    String? errorForSnackbar,
    Map<String, dynamic>? data,
    String? nameController,
    String? nisController,
    bool? showCurrentPassword,
    bool? showNewPassword,
    bool? showConfirmPassword,
    String? successChangePassword,
  }) {
    return ProfileState(
      isEditMode: isEditMode ?? this.isEditMode,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      errorForSnackbar: errorForSnackbar ?? this.errorForSnackbar,
      data: data ?? this.data,
      nameController: nameController ?? this.nameController,
      nisController: nisController ?? this.nisController,
      showCurrentPassword: showCurrentPassword ?? this.showCurrentPassword,
      showNewPassword: showNewPassword ?? this.showNewPassword,
      showConfirmPassword: showConfirmPassword ?? this.showConfirmPassword,
      successChangePassword: successChangePassword ?? this.successChangePassword,
    );
  }

  @override
  List<Object> get props {
    return [
      isEditMode,
      isLoading,
      error,
      errorForSnackbar,
      data,
      nameController,
      nisController,
      showCurrentPassword,
      showNewPassword,
      showConfirmPassword,
      successChangePassword,
    ];
  }
}
