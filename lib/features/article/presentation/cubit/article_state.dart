part of 'article_cubit.dart';

class ArticleState extends Equatable {
  // Loading state
  final bool artikelIsLoading;
  final bool videoIsLoading;
  final bool kategoriIsLoading;
  // Data state
  final List<Map<String, dynamic>> artikelData;
  final List<Map<String, dynamic>> videoData;
  final List<Map<String, dynamic>> kategoriData;
  final List<Map<String, dynamic>> artikelDataKategori;
  final List<Map<String, dynamic>> videoDataKategori;
  // Error state
  final String kategoriDataError;
  final String videoDataError;
  final String artikelDataError;
  final String messageError;

  const ArticleState({
    this.artikelIsLoading = false,
    this.kategoriIsLoading = false,
    this.videoIsLoading = false,
    this.kategoriDataError = '',
    this.videoDataError = '',
    this.artikelDataError = '',
    this.messageError = '',
    this.artikelData = const [],
    this.videoData = const [],
    this.kategoriData = const [],
    this.artikelDataKategori = const [],
    this.videoDataKategori = const [],
  });

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
      kategoriDataError: kategoriDataError ?? this.kategoriDataError,
      videoDataError: videoDataError ?? this.videoDataError,
      artikelDataError: artikelDataError ?? this.artikelDataError,
      messageError: messageError ?? this.messageError,
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

// Initial state
// class ArticleInitial extends ArticleState {
//   const ArticleInitial() : super();
// }

// // Loading state
// class ArticleLoading extends ArticleState {
//   const ArticleLoading({
//     required super.artikelIsLoading,
//     required super.videoIsLoading,
//     required super.kategoriIsLoading,
//   });
//   ArticleLoading copyWith({
//     final bool? artikelIsLoading,
//     final bool? videoIsLoading,
//     final bool? kategoriIsLoading,
//   }) {
//     return ArticleLoading(
//       artikelIsLoading: artikelIsLoading ?? this.artikelIsLoading,
//       videoIsLoading: videoIsLoading ?? this.videoIsLoading,
//       kategoriIsLoading: kategoriIsLoading ?? this.kategoriIsLoading,
//     );
//   }

//   @override
//   List<Object> get props => [
//         artikelIsLoading,
//         videoIsLoading,
//         kategoriIsLoading,
//       ];
// }

// // Data state
// class ArticleData extends ArticleState {
//   const ArticleData({
//     required super.artikelData,
//     required super.videoData,
//     required super.kategoriData,
//     required super.artikelDataKategori,
//     required super.videoDataKategori,
//   });
//   ArticleData copyWith({
//     final List<Map<String, dynamic>>? artikelData,
//     final List<Map<String, dynamic>>? videoData,
//     final List<Map<String, dynamic>>? kategoriData,
//     final List<Map<String, dynamic>>? artikelDataKategori,
//     final List<Map<String, dynamic>>? videoDataKategori,
//   }) {
//     return ArticleData(
//       artikelData: artikelData ?? this.artikelData,
//       videoData: videoData ?? this.videoData,
//       kategoriData: kategoriData ?? this.kategoriData,
//       artikelDataKategori: artikelDataKategori ?? this.artikelDataKategori,
//       videoDataKategori: videoDataKategori ?? this.videoDataKategori,
//     );
//   }
// }

// // Error state
// class ArticleError extends ArticleState {
//   const ArticleError({
//     required super.kategoriDataError,
//     required super.videoDataError,
//     required super.artikelDataError,
//     required super.messageError,
//   });
//   ArticleError copyWith({
//     final String? kategoriDataError,
//     final String? videoDataError,
//     final String? artikelDataError,
//     final String? messageError,
//   }) {
//     return ArticleError(
//       kategoriDataError: kategoriDataError ?? this.kategoriDataError,
//       videoDataError: videoDataError ?? this.videoDataError,
//       artikelDataError: artikelDataError ?? this.artikelDataError,
//       messageError: messageError ?? this.messageError,
//     );
//   }
// }
