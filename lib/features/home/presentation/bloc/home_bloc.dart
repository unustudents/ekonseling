import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import '../../../../supabase_config.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.initial()) {
    on<LoadDataUserEvent>(_onFetchUserData);
    on<LoadStreamVideoEvent>(_onStreamVideoData);
    on<LoadDataKonselorEvent>(_onFetchKonselorData);
    on<LoadDataArtikelEvent>(_onFetchArtikelData);
    add(LoadDataUserEvent());
    add(LoadStreamVideoEvent());
    add(LoadDataKonselorEvent());
    add(LoadDataArtikelEvent());
  }

  @override
  void onChange(Change<HomeState> change) {
    log(name: 'onChange()', change.currentState.toString());
    super.onChange(change);
  }

  Future<void> _onFetchUserData(LoadDataUserEvent event, Emitter<HomeState> emit) async {
    try {
      final userId = SupabaseConfig.client.auth.currentUser!.id;
      // FETCH USER NAME
      final userResponse = await SupabaseConfig.client.from('users').select('name').eq('id', userId).single();
      emit(state.copyWith(userName: userResponse['name'].toString()));
      log('User Name: ${userResponse['name']}');
    } catch (e) {
      // Log error
      log(name: 'Home_Bloc', 'Error _onFetchUserData: $e');
      // Emit state untuk menangani error
      emit(state.copyWith(messageError: e.toString()));
    }
  }

  void _onStreamVideoData(LoadStreamVideoEvent event, Emitter<HomeState> emit) async {
    try {
      // Membuat stream dari tabel 'videos'
      final response = SupabaseConfig.client.from('videos').stream(primaryKey: ['id']);

      // Subscribe ke perubahan real-time
      // SupabaseConfig.client
      //     .channel('public:videos')
      //     .onPostgresChanges(
      //         event: PostgresChangeEvent.all,
      //         schema: 'public',
      //         table: 'videos',
      //         callback: (PostgresChangePayload payload) => print('Payload: $payload'))
      //     .subscribe();

      // Emit state setiap kali stream mengirimkan data baru
      await emit.forEach(
        response,
        onData: (data) => state.copyWith(dataVideo: data),
        onError: (error, stackTrace) => state.copyWith(dataVideoError: error.toString()),
      );
    } catch (e) {
      log(name: 'Home_Bloc', 'Error _onStreamVideoData: $e');
      // Emit state untuk menangani error
      emit(state.copyWith(messageError: e.toString()));
    }
  }

  Future<void> _onFetchKonselorData(LoadDataKonselorEvent event, Emitter<HomeState> emit) async {
    try {
      final konselorResponse = await SupabaseConfig.client.from('users_admin').select('name, profile_url');
      final konselorProfiles = List<Map<String, dynamic>>.from(
        konselorResponse.map(
          (profile) => {
            'name': profile['name'],
            'url_profil': profile['profile_url'],
          },
        ),
      );
      emit(state.copyWith(konselorProfiles: konselorProfiles));
    } catch (e) {
      log(name: 'Home_Bloc', 'Error _onFetchKonselorData: $e');
      emit(state.copyWith(messageError: e.toString()));
    }
  }

  Future<void> _onFetchArtikelData(LoadDataArtikelEvent event, Emitter<HomeState> emit) async {
    try {
      // Membuat stream dari tabel 'article'
      final response = await SupabaseConfig.client
          .from('article')
          .select('title, content, image_url, created_at, read_time_minutes, users_admin(name, profile_url)')
          .order('created_at')
          .limit(1)
          .maybeSingle();
      String date = DateFormat('d/M/y').format(DateTime.parse(response?['created_at']));
      final data = {
        'title': response?['title'] ?? '-',
        'author': response?['users_admin']?['name'] ?? '-',
        'profile_url': response?['users_admin']?['profile_url'] ?? '-',
        'content': response?['content'] ?? '-',
        'image_url': response?['image_url'] ?? '-',
        'created_at': date,
        'read_time_minutes': response?['read_time_minutes'] ?? '-',
      };
      emit(state.copyWith(latestArticle: data));
      log('Latest Article: $response');
    } catch (e) {
      emit(state.copyWith(messageError: e.toString()));
    }
  }
}
