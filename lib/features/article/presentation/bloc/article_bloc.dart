import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import '../../../../supabase_config.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  ArticleBloc() : super(ArticleState.initial()) {
    on<LoadDataArtikelEvent>(_onFetchArtikelData);
    on<LoadDataVideoEvent>(_onFetchVideoData);
    on<LoadDataKategoriEvent>(_onKategoriData);
    on<LoadKategoriDataArtikelEvent>(_onFetchArtikelDataKategori);
    on<LoadKategoriDataVideoEvent>(_onFetchVideoDataKategori);
    add(LoadDataArtikelEvent());
    add(LoadDataVideoEvent());
    add(LoadDataKategoriEvent());
  }

  // @override
  // void onChange(Change<ArticleState> change) {
  //   // Always call super.onChange with the current change
  //   super.onChange(change);
  // }

  // FOR ARTIKEL TAB
  Future<void> _onFetchArtikelData(
      LoadDataArtikelEvent event, Emitter<ArticleState> emit) async {
    emit(state.copyWith(artikelIsLoading: true));
    try {
      // Membuat stream dari tabel 'article'
      final List<Map<String, dynamic>> response = await SupabaseConfig.client
          .from('article')
          .select(
              'title, content, image_url, created_at, read_time_minutes, users_admin(name, profile_url), categories(name)')
          .order('created_at');

      // Periksa apakah response valid
      if (response.isEmpty) {
        emit(state.copyWith(
            artikelDataError: 'Admin belum menambahkan artikel.'));
        return;
      }

      // Format dan peta semua artikel
      final data = response.map((article) {
        final date = DateFormat('d, MMM y')
            .format(DateTime.parse(article['created_at']));
        return {
          'title': article['title'] ?? '-',
          'author': article['users_admin']?['name'] ?? '-',
          'categories': article['categories']?['name'] ?? '',
          'profile_url': article['users_admin']?['profile_url'] ?? '-',
          'content': article['content'] ?? '-',
          'image_url': article['image_url'] ?? '-',
          'created_at': date,
          'read_time_minutes': article['read_time_minutes'] ?? '-',
        };
      }).toList();
      emit(state.copyWith(artikelData: data, artikelDataKategori: data));
    } catch (e) {
      emit(state.copyWith(artikelDataError: e.toString()));
    } finally {
      emit(state.copyWith(artikelIsLoading: false));
    }
  }

  // FOR VIDEO TAB
  Future<void> _onFetchVideoData(
      LoadDataVideoEvent event, Emitter<ArticleState> emit) async {
    emit(state.copyWith(videoIsLoading: true));
    try {
      // Membuat stream dari tabel 'video'
      final List<Map<String, dynamic>> response = await SupabaseConfig.client
          .from('videos')
          .select('title, url_video, created_at, subtitle')
          .order('created_at');

      // Periksa apakah response valid
      if (response.isEmpty) {
        emit(state.copyWith(videoDataError: 'Admin belum menambahkan video.'));
        return;
      }

      // Format dan peta semua video
      final data = response.map((video) {
        return {
          'title': video['title'] ?? '-',
          'url_video': video['url_video'] ?? '-',
          'subtitle': video['subtitle'] ?? '-',
        };
      }).toList();

      emit(state.copyWith(videoData: data, videoDataKategori: data));
    } catch (e) {
      emit(state.copyWith(videoDataError: e.toString()));
    } finally {
      emit(state.copyWith(videoIsLoading: false));
    }
  }

  // FOR FILTERING
  void _onKategoriData(
      LoadDataKategoriEvent event, Emitter<ArticleState> emit) async {
    emit(state.copyWith(kategoriIsLoading: true));
    try {
      final response =
          await SupabaseConfig.client.from('categories').select('name');
      final data =
          response.map((kategori) => {'name': kategori['name']}).toList();
      final mergeData = [
        {'name': 'Semua'},
        ...data
      ];
      emit(state.copyWith(kategoriData: mergeData));
    } catch (e) {
      emit(state.copyWith(kategoriDataError: e.toString()));
    } finally {
      emit(state.copyWith(kategoriIsLoading: false));
    }
  }

  // FOR ARTICLES AFTER FILTERING
  void _onFetchArtikelDataKategori(
      LoadKategoriDataArtikelEvent event, Emitter<ArticleState> emit) async {
    // emit(state.copyWith(artikelIsLoading: true));
    final List<Map<String, dynamic>> filteredArtikel = state.artikelData
        .where((element) =>
            event.kategori == 'Semua' ||
            element['categories'] == event.kategori)
        .toList();
    emit(state.copyWith(artikelDataKategori: filteredArtikel));
  }

  // FOR VIDEOS AFTER FILTERING
  void _onFetchVideoDataKategori(
      LoadKategoriDataVideoEvent event, Emitter<ArticleState> emit) async {
    // emit(state.copyWith(artikelIsLoading: true));
    final List<Map<String, dynamic>> filteredVideos = state.videoData
        .where((element) =>
            event.kategori == 'Semua' ||
            element['categories'] == event.kategori)
        .toList();
    emit(state.copyWith(videoDataKategori: filteredVideos));
  }
}
