part of 'article_bloc.dart';

class ArticleState extends Equatable {
  final bool artikelIsLoading;
  final bool videoIsLoading;
  final bool kategoriIsLoading;

  final List<Map<String, dynamic>> artikelData;
  final List<Map<String, dynamic>> videoData;
  final List<Map<String, dynamic>> kategoriData;
  final List<Map<String, dynamic>> artikelDataKategori;
  final List<Map<String, dynamic>> videoDataKategori;

  final String kategoriDataError;
  final String videoDataError;
  final String artikelDataError;
  final String messageError;

  const ArticleState({
    required this.videoIsLoading,
    required this.kategoriIsLoading,
    required this.artikelIsLoading,
    required this.kategoriDataError,
    required this.videoDataError,
    required this.artikelDataError,
    required this.messageError,
    required this.artikelData,
    required this.videoData,
    required this.kategoriData,
    this.artikelDataKategori = const [],
    this.videoDataKategori = const [],
  });

  factory ArticleState.initial() {
    return const ArticleState(
      artikelData: [],
      videoData: [],
      kategoriData: [],
      messageError: '',
      videoDataError: '',
      artikelDataError: '',
      kategoriDataError: '',
      artikelIsLoading: false,
      videoIsLoading: false,
      kategoriIsLoading: false,
      artikelDataKategori: [],
      videoDataKategori: [],
    );
  }

  ArticleState copyWith({
    final bool? artikelIsLoading,
    final bool? videoIsLoading,
    final bool? kategoriIsLoading,
    final List<Map<String, dynamic>>? artikelData,
    final List<Map<String, dynamic>>? videoData,
    final List<Map<String, dynamic>>? kategoriData,
    final List<Map<String, dynamic>>? artikelDataKategori,
    final List<Map<String, dynamic>>? videoDataKategori,
    final String? kategoriDataError,
    final String? videoDataError,
    final String? artikelDataError,
    final String? messageError,
  }) {
    return ArticleState(
      artikelIsLoading: artikelIsLoading ?? this.artikelIsLoading,
      videoIsLoading: videoIsLoading ?? this.videoIsLoading,
      kategoriIsLoading: kategoriIsLoading ?? this.kategoriIsLoading,
      artikelData: artikelData ?? this.artikelData,
      videoData: videoData ?? this.videoData,
      kategoriData: kategoriData ?? this.kategoriData,
      artikelDataKategori: artikelDataKategori ?? this.artikelDataKategori,
      videoDataKategori: videoDataKategori ?? this.videoDataKategori,
      messageError: messageError ?? this.messageError,
      videoDataError: videoDataError ?? this.videoDataError,
      artikelDataError: artikelDataError ?? this.artikelDataError,
      kategoriDataError: kategoriDataError ?? this.kategoriDataError,
    );
  }

  @override
  List<Object> get props => [
        artikelIsLoading,
        videoIsLoading,
        kategoriIsLoading,
        artikelData,
        videoData,
        kategoriData,
        artikelDataKategori,
        videoDataKategori,
        messageError,
        videoDataError,
        artikelDataError,
        kategoriDataError,
      ];
}
