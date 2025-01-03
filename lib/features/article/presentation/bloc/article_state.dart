part of 'article_bloc.dart';

class ArticleState extends Equatable {
  final List<Map<String, dynamic>> artikelData;
  final List<Map<String, dynamic>> videoData;

  final String videoDataError;
  final String artikelDataError;
  final String messageError;

  const ArticleState({
    required this.videoDataError,
    required this.artikelDataError,
    required this.messageError,
    required this.artikelData,
    required this.videoData,
  });

  factory ArticleState.initial() {
    return const ArticleState(
      artikelData: [],
      videoData: [],
      messageError: '',
      videoDataError: '',
      artikelDataError: '',
    );
  }

  ArticleState copyWith({
    final List<Map<String, dynamic>>? artikelData,
    final List<Map<String, dynamic>>? videoData,
    final String? videoDataError,
    final String? artikelDataError,
    final String? messageError,
  }) {
    return ArticleState(
      artikelData: artikelData ?? this.artikelData,
      videoData: videoData ?? this.videoData,
      messageError: messageError ?? this.messageError,
      videoDataError: videoDataError ?? this.videoDataError,
      artikelDataError: artikelDataError ?? this.artikelDataError,
    );
  }

  @override
  List<Object> get props => [
        artikelData,
        videoData,
        messageError,
        videoDataError,
        artikelDataError,
      ];
}

// class ArticleInitial extends ArticleState {}
