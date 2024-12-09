import 'package:flutter_bloc/flutter_bloc.dart';

enum NavigationState { home, article, profile, task }

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationState.home);

  void showHome() => emit(NavigationState.home);
  void showArticle() => emit(NavigationState.article);
  void showProfile() => emit(NavigationState.profile);
  void showTask() => emit(NavigationState.task);
}
