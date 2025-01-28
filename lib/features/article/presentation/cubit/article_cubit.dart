import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import '../../../../supabase_config.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

part 'article_state.dart';

class ArticleCubit extends Cubit<ArticleState> {
  ArticleCubit() : super(ArticleState()) {
    _onFetchArtikelData();
    _onFetchVideoData();
    _onKategoriData();
  }

  // ARTIKEL TAB -----------------------------------------------------
  // Function - Mengambil data artikel
  void _onFetchArtikelData() async {
    emit(state.copyWith(artikelIsLoading: true));
    try {
      // Mengambil data artikel
      final List<Map<String, dynamic>> response =
          await SupabaseConfig.client.from('article').select('title, content, image_url, created_at, read_time_minutes, users_admin(name, profile_url), categories(name)').order('created_at');
      // Periksa apakah response valid
      if (response.isEmpty) {
        emit(state.copyWith(artikelDataError: 'Admin belum menambahkan artikel.'));
        return;
      }
      // Format dan peta semua artikel
      final data = response.map((article) {
        // Format tanggal
        final date = DateFormat('d, MMM y').format(DateTime.parse(article['created_at']));
        // Return data artikel
        return {
          'title': article['title'] ?? '',
          'author': article['users_admin']?['name'] ?? '',
          'categories': article['categories']?['name'] ?? '',
          'profile_url': article['users_admin']?['profile_url'] ?? '',
          'content': article['content'] ?? '',
          'image_url': article['image_url'] ?? '',
          'created_at': date,
          'read_time_minutes': article['read_time_minutes'] ?? 0,
        };
      }).toList();
      emit(state.copyWith(artikelData: data, artikelDataKategori: data));
    } catch (e) {
      emit(state.copyWith(artikelDataError: 'Gagal mengambil data artikel.'));
    } finally {
      emit(state.copyWith(artikelIsLoading: false));
    }
  }

  // VIDEO TAB -----------------------------------------------------
  // Function - Mengambil data video
  void _onFetchVideoData() async {
    emit(state.copyWith(videoIsLoading: true));
    try {
      // Mengambil data video
      final List<Map<String, dynamic>> response = await SupabaseConfig.client.from('videos').select('title, url_video, thumbnail, subtitle, categories(name)').order('created_at');
      // Periksa apakah response valid
      if (response.isEmpty) {
        emit(state.copyWith(videoDataError: 'Admin belum menambahkan video.'));
        return;
      }
      // Format dan peta semua video
      final data = response.map((video) {
        return {
          'title': video['title'] ?? '',
          'url_video': video['url_video'] ?? '',
          'thumbnail': video['thumbnail'] ?? '',
          'subtitle': video['subtitle'] ?? '',
          'categories': video['categories']?['name'] ?? '',
        };
      }).toList();
      emit(state.copyWith(videoData: data, videoDataKategori: data));
    } catch (e) {
      emit(state.copyWith(videoDataError: 'Gagal mengambil data video.'));
    } finally {
      emit(state.copyWith(videoIsLoading: false));
    }
  }

  // FILTER -----------------------------------------------------
  // Function - Memfilter data berdasarkan kategori
  Future<void> _onKategoriData() async {
    emit(state.copyWith(kategoriIsLoading: true));
    try {
      // Mengambil data kategori
      final List<Map<String, dynamic>> response = await SupabaseConfig.client.from('categories').select('name');
      // Petakan nama kategori
      final data = response.map((kategori) => {'name': kategori['name']}).toList();
      // Gabungkan data kategori dengan data 'Semua'
      final mergeData = [
        {'name': 'Semua'},
        ...data,
      ];
      emit(state.copyWith(kategoriData: mergeData));
    } catch (e) {
      emit(state.copyWith(kategoriDataError: 'Gagal mengambil data kategori.'));
    } finally {
      emit(state.copyWith(kategoriIsLoading: false));
    }
  }

  // Function - Memfilter data artikel berdasarkan kategori
  void onFilterArtikelData(String kategori) {
    // Filter data artikel berdasarkan kategori
    final List<Map<String, dynamic>> filteredArtikel = state.artikelData.where((element) => kategori == 'Semua' || element['categories'] == kategori).toList();
    emit(state.copyWith(artikelDataKategori: filteredArtikel));
  }

  // Function - Memfilter data video berdasarkan kategori
  void onFilterVideoData(String kategori) {
    // Filter data video berdasarkan kategori
    final List<Map<String, dynamic>> filteredVideo = state.videoData.where((element) => kategori == 'Semua' || element['categories'] == kategori).toList();
    emit(state.copyWith(videoDataKategori: filteredVideo));
  }
}
