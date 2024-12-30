// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final String userName;
  final List<Map<String, dynamic>> videoUrls;
  final List<Map<String, dynamic>> konselorProfiles;
  final Map<String, dynamic> latestArticle;

  const HomeLoaded({required this.userName, required this.videoUrls, required this.konselorProfiles, required this.latestArticle});

  @override
  List<Object> get props => [userName, videoUrls, konselorProfiles, latestArticle];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object> get props => [message];
}
