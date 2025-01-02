part of 'home_bloc.dart';

class HomeState extends Equatable {
  final String userName;
  final List<Map<String, dynamic>> konselorProfiles;
  final Map<String, dynamic> latestArticle;
  final List<Map<String, dynamic>> dataVideo;

  final String dataVideoError;
  final String messageError;

  const HomeState({
    required this.userName,
    required this.konselorProfiles,
    required this.latestArticle,
    required this.dataVideo,
    required this.dataVideoError,
    required this.messageError,
  });
  factory HomeState.initial() {
    return const HomeState(
      userName: '',
      konselorProfiles: [],
      latestArticle: {},
      dataVideo: [],
      dataVideoError: '',
      messageError: '',
    );
  }
  HomeState copyWith({
    final String? userName,
    final List<Map<String, dynamic>>? konselorProfiles,
    final Map<String, dynamic>? latestArticle,
    final List<Map<String, dynamic>>? dataVideo,
    final String? dataVideoError,
    final String? messageError,
  }) {
    return HomeState(
      userName: userName ?? this.userName,
      konselorProfiles: konselorProfiles ?? this.konselorProfiles,
      latestArticle: latestArticle ?? this.latestArticle,
      dataVideo: dataVideo ?? this.dataVideo,
      dataVideoError: dataVideoError ?? this.dataVideoError,
      messageError: messageError ?? this.messageError,
    );
  }

  @override
  List<Object> get props => [userName, konselorProfiles, latestArticle, dataVideo, dataVideoError, messageError];
}

// class HomeInitialState extends HomeState {
//   const HomeInitialState({
//     required super.userName,
//     required super.konselorProfiles,
//     required super.latestArticle,
//     required super.dataVideo,
//     required super.dataVideoError,
//     required super.messageError,
//   });
// }

// class HomeLoading extends HomeState {}

// class HomeLoaded extends HomeState {
//   final String userName;
//   // final List<Map<String, dynamic>> videoUrls;
//   final List<Map<String, dynamic>> konselorProfiles;
//   final Map<String, dynamic> latestArticle;

//   const HomeLoaded({required this.userName, required this.konselorProfiles, required this.latestArticle});

//   @override
//   List<Object> get props => [userName, konselorProfiles, latestArticle];
// }

// class HomeError extends HomeState {
//   final String message;

//   const HomeError(this.message);

//   @override
//   List<Object> get props => [message];
// }

// class HomeVideoDataStream extends HomeState {
//   final List<Map<String, dynamic>> dataVideo;

//   const HomeVideoDataStream({required this.dataVideo});

//   @override
//   List<Object> get props => [dataVideo];
// }
