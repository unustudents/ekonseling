part of 'article_bloc.dart';

abstract class ArticleEvent extends Equatable {
  const ArticleEvent();

  @override
  List<Object> get props => [];
}

class LoadDataArtikelEvent extends ArticleEvent {}

class LoadDataFilterEvent extends ArticleEvent {}

class LoadDataVideoEvent extends ArticleEvent {}

class LoadDataKategoriEvent extends ArticleEvent {}

class LoadKategoriDataArtikelEvent extends ArticleEvent {
  final String kategori;

  const LoadKategoriDataArtikelEvent({required this.kategori});

  @override
  List<Object> get props => [kategori];
}
