import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../supabase_config.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<FetchDataEvent>(_onFetchUserData);
    on<StreamVideoDataEvent>(_onStreamVideoData);
  }

  @override
  void onChange(Change<HomeState> change) {
    print(change);
    super.onChange(change);
  }

  _onStreamVideoData(StreamVideoDataEvent event, Emitter<HomeState> emit) async {
    try {
      // emit(HomeLoading());
      final response = SupabaseConfig.client.from('videos').stream(primaryKey: ['id']).order('url_video').order('title').order('subtitle');
      SupabaseConfig.client
          .channel('public:videos')
          .onPostgresChanges(
              event: PostgresChangeEvent.all,
              schema: 'public',
              table: 'videos',
              callback: (PostgresChangePayload payload) => print('Payload: $payload'))
          .subscribe();
      await emit.forEach(
        response,
        onData: (data) => HomeVideoDataStream(dataVideo: data),
        onError: (error, stackTrace) => HomeError(error.toString()),
      );
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> _onFetchUserData(FetchDataEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final userId = SupabaseConfig.client.auth.currentUser!.id;
      // FETCH USER NAME
      final userResponse = await SupabaseConfig.client.from('users').select('name').eq('id', userId).single();
      final String userName = userResponse['name'].toString();

      // FETCH VIDEOS URLS
      // final videoResponse = await SupabaseConfig.client.from('videos').select('url_video, title, subtitle');
      // final videoResponse = await SupabaseConfig.client.from('videos').select('url_video, title, subtitle');
      // print("HomeBloc - Video Response: $videoResponse");
      // final videoUrls = List<Map<String, dynamic>>.from(
      //   videoResponse.map(
      //     (video) => {
      //       'url_video': video['url_video'],
      //       'title': video['title'],
      //       'subtitle': video['subtitle'],
      //     },
      //   ),
      // );

      // FETCH KONSELOR PROFILES
      final konselorResponse = await SupabaseConfig.client.from('users_admin').select('name, profile_url');
      final konselorProfiles = List<Map<String, dynamic>>.from(
        konselorResponse.map(
          (profile) => {
            'nama': profile['nama'],
            'url_profil': profile['profile_url'],
          },
        ),
      );

      // Fetch the latest article
      final articleResponse = await SupabaseConfig.client
          .from('article')
          .select('title, content, image_url, created_at, read_time_minutes, users_admin(name, profile_url)')
          .order('created_at', ascending: false)
          .limit(1)
          .maybeSingle();
      print("HomeBloc - Data Artikel: $articleResponse");
      final latestArticle = {
        'title': articleResponse?['title'] ?? '-',
        'author': articleResponse?['users_admin']?['name'] ?? '-',
        'profile_url': articleResponse?['users_admin']?['profile_url'] ?? '-',
        'content': articleResponse?['content'] ?? '-',
        'image_url': articleResponse?['image_url'] ?? '-',
        'created_at': articleResponse?['created_at'] ?? '-',
        'read_time_minutes': articleResponse?['read_time_minutes'] ?? '-',
      };

      emit(HomeLoaded(userName: userName, konselorProfiles: konselorProfiles, latestArticle: latestArticle));
    } catch (e) {
      print('Error HomeBloc: $e');
      emit(HomeError('Error fetching name: $e'));
    }
  }
}
