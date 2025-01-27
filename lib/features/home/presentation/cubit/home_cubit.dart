import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../supabase_config.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState()) {
    _onFetchUserData();
  }

  _onFetchUserData() async {
    try {
      final String userId = SupabaseConfig.client.auth.currentUser!.id;
      final Map<String, dynamic> userResponse = await SupabaseConfig.client.from('users').select('name').eq('id', userId).single();
      emit(state.copyWith(userName: userResponse['name'].toString()));
    } catch (e) {}
  }
}
