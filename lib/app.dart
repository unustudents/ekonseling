import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'features/article/presentation/pages/article_screen.dart';
import 'features/home/presentation/pages/home_screen.dart';
import 'features/profile/presentation/pages/profile_screen.dart';
import 'features/task/presentation/pages/task_screen.dart';
import 'navigation_cubit.dart';

class AppScreen extends StatelessWidget {
  const AppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) => _getScreenForState(state),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  /// Mengembalikan layar yang sesuai dengan arus [NavigationState].
  Widget _getScreenForState(NavigationState state) {
    switch (state) {
      case NavigationState.home:
        return const HomeScreen();
      case NavigationState.article:
        return const ArticleScreen();
      case NavigationState.task:
        return const TaskScreen();
      case NavigationState.profile:
        return const ProfileScreen();
      default:
        return const SizedBox.shrink();
    }
  }

  /// Membangun bottom navigation bar.
  Widget _buildBottomNavigationBar(BuildContext context) {
    final currentState = context.watch<NavigationCubit>().state;
    return SalomonBottomBar(
      currentIndex: _getSelectedIndex(currentState),
      onTap: (index) => _onBottomNavTap(context, index),
      items: [
        SalomonBottomBarItem(icon: const Icon(Icons.home_outlined), title: const Text("Home")),
        SalomonBottomBarItem(icon: const Icon(Icons.article), title: const Text("Artikel"), selectedColor: Colors.red),
        SalomonBottomBarItem(icon: const Icon(Icons.task), title: const Text("Tugas"), selectedColor: Colors.green),
        SalomonBottomBarItem(icon: const Icon(Icons.person_outline), title: const Text("Profil"), selectedColor: Colors.brown),
      ],
    );
  }

  /// Menangani event ketika bottom navigation ditekan.
  void _onBottomNavTap(BuildContext context, int index) {
    final navigationCubit = context.read<NavigationCubit>();
    switch (index) {
      case 0:
        navigationCubit.showHome();
        break;
      case 1:
        navigationCubit.showArticle();
        break;
      case 2:
        navigationCubit.showTask();
        break;
      case 3:
        navigationCubit.showProfile();
        break;
    }
  }

  /// Memetakan [NavigationState] ke index bottom navigation bar yang sesuai.
  int _getSelectedIndex(NavigationState state) {
    switch (state) {
      case NavigationState.home:
        return 0;
      case NavigationState.article:
        return 1;
      case NavigationState.task:
        return 2;
      case NavigationState.profile:
        return 3;
      default:
        return 0;
    }
  }
}
