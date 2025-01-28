import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import '../../../../supabase_config.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState()) {
    _onFetchUserData();
    _onFetchVideoData();
    _onFetchKonselorData();
    _onFetchArtikelData();
  }

  // Mengambil data user
  void _onFetchUserData() async {
    try {
      // Mendapatkan user ID
      final String userId = SupabaseConfig.client.auth.currentUser!.id;
      // Mengambil data user berdasarkan ID
      final Map<String, dynamic> userResponse = await SupabaseConfig.client.from('users').select('name').eq('id', userId).single();
      // Mengubah state dengan nama user
      emit(state.copyWith(userName: userResponse['name'].toString()));
    } catch (e) {
      // Log error
      print('Error _onFetchUserData: $e');
      // Emit state untuk menangani error
      // emit(state.copyWith(messageError: e.toString()));
    }
  }

  // Mengambil data video
  void _onFetchVideoData() async {
    try {
      // Mengambil data video
      final List<Map<String, dynamic>> response = await SupabaseConfig.client.from('videos').select('url_video, title, subtitle, thumbnail, categories(name)');
      // Mengubah data response menjadi null safety
      final List<Map<String, dynamic>> data = response
          .map((video) => {
                'urlVideo': video['url_video'] ?? '',
                'title': video['title'] ?? '',
                'subtitle': video['subtitle'] ?? 'Tidak ada keterangan',
                'thumbnail': video['thumbnail'] ?? '',
                'categories': video['categories']?['name'] ?? '',
              })
          .toList();
      // Mengubah state dengan data video
      emit(state.copyWith(dataVideo: data));
    } catch (e) {
      // Log error
      print('Error _onFetchVideoData: $e');
    }
  }

  _onFetchKonselorData() async {
    try {
      // Mengambil data konselor
      final response = await SupabaseConfig.client.from('users_admin').select('name, profile_url');
      // Mengubah data response menjadi null safety
      final data = response
          .map((profile) => {
                'name': profile['name'] ?? '',
                'url_profil': profile['profile_url'] ?? '',
              })
          .toList();
      // Mengubah state dengan data konselor
      emit(state.copyWith(konselorProfiles: data));
    } catch (e) {
      // Log error
      print('Error _onFetchKonselorData: $e');
    }
  }

  _onFetchArtikelData() async {
    try {
      // Mengambil data artikel
      final response = await SupabaseConfig.client.from('article').select('title, content, image_url, created_at, read_time_minutes, users_admin(name, profile_url)').order('created_at').limit(1).maybeSingle();
      // Mengubah format tanggal
      String date = DateFormat('d/M/y').format(DateTime.parse(response?['created_at']));
      // Mengubah data response menjadi null safety
      final data = {
        'title': response?['title'] ?? '-',
        'author': response?['users_admin']?['name'] ?? '-',
        'profile_url': response?['users_admin']?['profile_url'] ?? '-',
        'content': response?['content'] ?? '-',
        'image_url': response?['image_url'] ?? '-',
        'created_at': date,
        'read_time_minutes': response?['read_time_minutes'] ?? '-',
      };
      // Mengubah state dengan data artikel
      emit(state.copyWith(latestArticle: data));
    } catch (e) {
      // Log error
      print('Error _onFetchArtikelData: $e');
    }
  }
}
