import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'dependency_injection.dart';
import 'features/auth/presentation/pages/welcome_screen.dart';
import 'navigation_cubit.dart';
import 'supabase_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SupabaseConfig.initialize();
  // Inisialisasi dependency injection
  await DependencyInjection.init();

  runApp(
    DevicePreview(
      enabled: !kReleaseMode && kIsWeb,
      builder: (BuildContext context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationCubit(),
      child: MaterialApp(
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        title: 'E-Konseling',
        theme: ThemeData(
          fontFamily: "Urbanist",
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            titleTextStyle: TextStyle(color: Colors.black, fontFamily: "Urbanist", fontSize: 15, fontWeight: FontWeight.bold),
          ),
          useMaterial3: true,
        ),
        // home: BlocProvider(create: (_) => NavigationCubit(), child: const AppScreen()),
        home: const RootScreen(),
      ),
    );
  }
}

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      // stream: FirebaseAuth.instance.authStateChanges(),
      stream: SupabaseConfig.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) return Scaffold(body: Center(child: CircularProgressIndicator()));
        print('Snapshot hasdata -> ${snapshot.data}');
        if (snapshot.data?.session != null) return AppScreen();
        return WelcomeScreen();
      },
    );
  }
}
