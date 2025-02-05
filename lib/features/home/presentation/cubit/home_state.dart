part of 'home_cubit.dart';

class HomeState extends Equatable {
  final String userName;
  final List<Map<String, dynamic>> konselorProfiles;
  final Map<String, dynamic> latestArticle;
  final List<Map<String, dynamic>> dataVideo;
  final String dataVideoError;
  final String messageError;
  final bool isPermission;

  const HomeState({
    this.userName = '',
    this.konselorProfiles = const [],
    this.latestArticle = const {},
    this.dataVideo = const [],
    this.dataVideoError = '',
    this.messageError = '',
    this.isPermission = false,
  });
  HomeState copyWith({
    final String? userName,
    final List<Map<String, dynamic>>? konselorProfiles,
    final Map<String, dynamic>? latestArticle,
    final List<Map<String, dynamic>>? dataVideo,
    final String? dataVideoError,
    final String? messageError,
    final bool? isPermission,
  }) {
    return HomeState(
      userName: userName ?? this.userName,
      konselorProfiles: konselorProfiles ?? this.konselorProfiles,
      latestArticle: latestArticle ?? this.latestArticle,
      dataVideo: dataVideo ?? this.dataVideo,
      dataVideoError: dataVideoError ?? this.dataVideoError,
      messageError: messageError ?? this.messageError,
      isPermission: isPermission ?? this.isPermission,
    );
  }

  @override
  List<Object> get props => [
        userName,
        konselorProfiles,
        latestArticle,
        dataVideo,
        dataVideoError,
        messageError,
        isPermission,
      ];
}
