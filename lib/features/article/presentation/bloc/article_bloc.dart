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
    add(LoadDataArtikelEvent());
    add(LoadDataVideoEvent());
  }

  Future<void> _onFetchArtikelData(LoadDataArtikelEvent event, Emitter<ArticleState> emit) async {
    try {
      // Membuat stream dari tabel 'article'
      final List<Map<String, dynamic>> response = await SupabaseConfig.client
          .from('article')
          .select('title, content, image_url, created_at, read_time_minutes, users_admin(name, profile_url)')
          .order('created_at');

      // Periksa apakah response valid
      if (response.isEmpty) {
        emit(state.copyWith(messageError: 'No articles found.'));
        return;
      }

      // Format dan peta semua artikel
      final data = response.map((article) {
        final date = DateFormat('d, MMM y').format(DateTime.parse(article['created_at']));
        return {
          'title': article['title'] ?? '-',
          'author': article['users_admin']['name'] ?? '-',
          'profile_url': article['users_admin']['profile_url'] ?? '-',
          'content': article['content'] ?? '-',
          'image_url': article['image_url'] ?? '-',
          'created_at': date,
          'read_time_minutes': article['read_time_minutes'] ?? '-',
        };
      }).toList();

      emit(state.copyWith(artikelData: data));
    } catch (e) {
      emit(state.copyWith(messageError: e.toString()));
    }
  }

  Future<void> _onFetchVideoData(LoadDataVideoEvent event, Emitter<ArticleState> emit) async {
    try {
      // Membuat stream dari tabel 'video'
      final List<Map<String, dynamic>> response =
          await SupabaseConfig.client.from('videos').select('title, url_video, created_at, subtitle').order('created_at');

      // Periksa apakah response valid
      if (response.isEmpty) {
        emit(state.copyWith(messageError: 'Admin belum menambahkan video.'));
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

      emit(state.copyWith(videoData: data));
    } catch (e) {
      emit(state.copyWith(messageError: e.toString()));
    }
  }
}
