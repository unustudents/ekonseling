part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class FetchDataEvent extends HomeEvent {}

class LoadStreamVideoEvent extends HomeEvent {}

class LoadDataKonselorEvent extends HomeEvent {}

class LoadDataArtikelEvent extends HomeEvent {}
