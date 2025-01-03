part of 'article_bloc.dart';

class ArticleState extends Equatable {
  final List<Map<String, dynamic>> artikelData;
  final Map<String, dynamic> videoData;
  final Map<String, dynamic> artikelDataById;

  final String videoDataError;
  final String artikelDataError;
  final String artikelDataByIdError;
  final String messageError;

  const ArticleState({
    required this.artikelDataById,
    required this.artikelDataByIdError,
    required this.videoDataError,
    required this.artikelDataError,
    required this.messageError,
    required this.artikelData,
    required this.videoData,
  });

  factory ArticleState.initial() {
    return const ArticleState(
      artikelData: [],
      videoData: {},
      messageError: '',
      videoDataError: '',
      artikelDataError: '',
      artikelDataById: {},
      artikelDataByIdError: '',
    );
  }

  ArticleState copyWith({
    final List<Map<String, dynamic>>? artikelData,
    final Map<String, dynamic>? videoData,
    final String? videoDataError,
    final String? artikelDataError,
    final String? messageError,
    final Map<String, dynamic>? artikelDataById,
    final String? artikelDataByIdError,
  }) {
    return ArticleState(
      artikelData: artikelData ?? this.artikelData,
      videoData: videoData ?? this.videoData,
      messageError: messageError ?? this.messageError,
      videoDataError: videoDataError ?? this.videoDataError,
      artikelDataError: artikelDataError ?? this.artikelDataError,
      artikelDataByIdError: artikelDataByIdError ?? this.artikelDataByIdError,
      artikelDataById: artikelDataById ?? this.artikelDataById,
    );
  }

  @override
  List<Object> get props => [
        artikelData,
        videoData,
        messageError,
        videoDataError,
        artikelDataError,
        artikelDataById,
        artikelDataByIdError
      ];
}

// class ArticleInitial extends ArticleState {}
