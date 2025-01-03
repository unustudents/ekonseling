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
    on<LoadDataArtikelByIdEvent>(_onFetchArtikelDataById);
    add(LoadDataArtikelEvent());
  }

  Future<void> _onFetchArtikelData(
      LoadDataArtikelEvent event, Emitter<ArticleState> emit) async {
    try {
      // Membuat stream dari tabel 'article'
      final List<Map<String, dynamic>> response = await SupabaseConfig.client
          .from('article')
          .select(
              'id, title, content, image_url, created_at, read_time_minutes, users_admin(name, profile_url)')
          .order('created_at');

      // Periksa apakah response valid
      if (response.isEmpty) {
        emit(state.copyWith(messageError: 'No articles found.'));
        return;
      }

      // Format dan peta semua artikel
      final data = response.map((article) {
        final date =
            DateFormat('d/M/y').format(DateTime.parse(article['created_at']));
        return {
          'id': article['id'],
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

  void _onFetchArtikelDataById(
      LoadDataArtikelByIdEvent event, Emitter<ArticleState> emit) async {
    try {
      final Map<String, dynamic> response = await SupabaseConfig.client
          .from('article')
          .select(
              'title, content, image_url, created_at, read_time_minutes, users_admin(name, profile_url)')
          .eq('id', event.articleId)
          .single();

      if (response.isEmpty) {
        emit(state.copyWith(
            messageError: 'Article not found. Maybe it was deleted.'));
        return;
      }

      // final article = response;
      final String date =
          DateFormat('d/M/y').format(DateTime.parse(response['created_at']));
      final Map<String, dynamic> data = {
        'title': response['title'] ?? '-',
        'author': response['users_admin']['name'] ?? '-',
        'profile_url': response['users_admin']['profile_url'] ?? '-',
        'content': response['content'] ?? '-',
        'image_url': response['image_url'] ?? '-',
        'created_at': date,
        'read_time_minutes': response['read_time_minutes'] ?? '-',
      };

      emit(state.copyWith(artikelDataById: data));
    } catch (e) {
      emit(state.copyWith(messageError: e.toString()));
    }
  }
}
