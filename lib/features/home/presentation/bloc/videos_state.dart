part of 'videos_bloc.dart';

sealed class VideosState extends Equatable {
  const VideosState();
  
  @override
  List<Object> get props => [];
}

final class VideosInitial extends VideosState {}
