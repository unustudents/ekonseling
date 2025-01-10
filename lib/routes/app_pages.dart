// Professional Router Implementation in Flutter
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

// Screens Import
import '../features/article/presentation/bloc/article_bloc.dart';
import '../features/article/presentation/pages/article_screen.dart';
import '../features/article/presentation/pages/detail_article_screen.dart';
import '../features/auth/presentation/pages/forgot_screen.dart';
import '../features/auth/presentation/pages/login_screen.dart';
import '../features/auth/presentation/pages/register_screen.dart';
import '../features/auth/presentation/pages/welcome_screen.dart';
import '../features/home/presentation/pages/home_screen.dart';
import '../features/profile/presentation/bloc/profile_bloc.dart';
import '../features/profile/presentation/pages/ganti_password_screen.dart';
import '../features/profile/presentation/pages/profile_screen.dart';
import '../features/task/presentation/bloc/task_bloc.dart';
import '../features/task/presentation/pages/detail_task_screen.dart';
import '../features/task/presentation/pages/task_screen.dart';

export 'package:go_router/go_router.dart';

part 'app_routes.dart';

final GoRouter router = GoRouter(
  routes: [
    ShellRoute(
        builder: (context, state, child) {
          return Scaffold(
            body: SafeArea(child: child),
            bottomNavigationBar: SalomonBottomBar(
              currentIndex: _getSelectedIndex(state.uri.toString()),
              onTap: (index) {
                if (index == 0) context.goNamed(Routes.home);
                if (index == 1) context.goNamed(Routes.article);
                if (index == 2) context.goNamed(Routes.task);
                if (index == 3) context.goNamed(Routes.profile);
              },
              items: [
                SalomonBottomBarItem(icon: const Icon(Icons.home_outlined), title: const Text("Home")),
                SalomonBottomBarItem(icon: const Icon(Icons.article), title: const Text("Artikel"), selectedColor: Colors.red),
                SalomonBottomBarItem(icon: const Icon(Icons.task), title: const Text("Tugas"), selectedColor: Colors.green),
                SalomonBottomBarItem(icon: const Icon(Icons.person_outline), title: const Text("Profil"), selectedColor: Colors.brown),
              ],
            ),
          );
        },
        routes: [
          GoRoute(
            path: '/home',
            name: Routes.home,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/article',
            name: Routes.article,
            builder: (context, state) => BlocProvider(
              create: (context) => ArticleBloc(),
              child: const ArticleScreen(),
            ),
          ),
          GoRoute(
            path: '/task',
            name: Routes.task,
            builder: (context, state) => BlocProvider(
              create: (context) => TaskBloc(),
              child: const TaskScreen(),
            ),
          ),
          GoRoute(
            path: '/profile',
            name: Routes.profile,
            builder: (context, state) => BlocProvider(
              create: (context) => ProfileBloc(),
              child: const ProfileScreen(),
            ),
          ),
        ]),
    GoRoute(
      path: '/',
      name: Routes.welcome,
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/login',
      name: Routes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      name: Routes.register,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/forgot-password',
      name: Routes.forgotPassword,
      builder: (context, state) => const ForgotPassScreen(),
    ),
    GoRoute(
      path: '/detail-artikel',
      name: Routes.detailArticle,
      builder: (context, state) {
        final article = state.extra as Map<String, dynamic>?;
        if (article == null || article.isEmpty) {
          throw Exception('Data artikel harus dikirim melalui extra');
        }
        return DetailArticleScreen(articleMap: article);
      },
    ),
    GoRoute(
      path: '/change-password',
      name: Routes.changePassword,
      builder: (context, state) => const GantiPasswordScreen(),
    ),
    GoRoute(
      path: '/detail-task',
      name: Routes.detailTask,
      builder: (context, state) {
        final task = state.extra as String?;
        if (task == null || task.isEmpty) {
          throw Exception('Data task harus dikirim melalui extra');
        }
        return DetailTaskScreen(taskId: task);
      },
    ),
  ],
);

int _getSelectedIndex(String location) {
  if (location.startsWith('/home')) return 0;
  if (location.startsWith('/article')) return 1;
  if (location.startsWith('/task')) return 2;
  if (location.startsWith('/profile')) return 3;
  return 0;
}
