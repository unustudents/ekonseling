// Professional Router Implementation in Flutter
import 'package:ekonseling/supabase_config.dart';
import 'package:go_router/go_router.dart';

// Screens Import
import '../app.dart';
import '../features/article/presentation/pages/article_screen.dart';
import '../features/article/presentation/pages/detail_article_screen.dart';
import '../features/auth/presentation/pages/forgot_screen.dart';
import '../features/auth/presentation/pages/login_screen.dart';
import '../features/auth/presentation/pages/register_screen.dart';
import '../features/auth/presentation/pages/welcome_screen.dart';
import '../features/home/presentation/pages/home_screen.dart';
import '../features/profile/presentation/pages/ganti_password_screen.dart';
import '../features/profile/presentation/pages/profile_screen.dart';
import '../features/task/presentation/pages/detail_task_screen.dart';
import '../features/task/presentation/pages/task_screen.dart';

export 'package:go_router/go_router.dart';

part 'app_routes.dart';

final GoRouter router = GoRouter(
  // initialLocation: '/',
  redirect: (context, state) async {
    final session = SupabaseConfig.client.auth.currentSession;

    return session == null ? '/login' : null;
  },
  routes: [
    GoRoute(
      path: '/',
      name: Routes.app,
      builder: (context, state) => AppScreen(),
    ),
    GoRoute(
      path: '/welcome',
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
      path: '/home',
      name: Routes.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/article',
      name: Routes.article,
      builder: (context, state) => const ArticleScreen(),
    ),
    GoRoute(
      path: '/article/:id',
      name: Routes.detailArticle,
      builder: (context, state) => DetailArticleScreen(articleId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/profile',
      name: Routes.profile,
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/change-password',
      name: Routes.changePassword,
      builder: (context, state) => const GantiPasswordScreen(),
    ),
    GoRoute(
      path: '/task',
      name: Routes.task,
      builder: (context, state) => const TaskScreen(),
    ),
    GoRoute(
      path: '/task/:id',
      name: Routes.detailTask,
      builder: (context, state) => DetailTaskScreen(taskId: state.pathParameters['id']!),
    ),
  ],
);
