part of 'article_bloc.dart';

abstract class ArticleEvent extends Equatable {
  const ArticleEvent();

  @override
  List<Object> get props => [];
}

class LoadDataArtikelEvent extends ArticleEvent {}

class LoadDataFilterEvent extends ArticleEvent {}

class LoadDataVideoEvent extends ArticleEvent {}

class LoadDataArtikelByIdEvent extends ArticleEvent {
  final String articleId;
  const LoadDataArtikelByIdEvent({required this.articleId});

  @override
  List<Object> get props => [articleId];
}
