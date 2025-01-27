import 'package:flutter/material.dart';

import 'routes/app_pages.dart';
import 'supabase_config.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _sreaming = SupabaseConfig.client.auth.onAuthStateChange.listen(
    (event) {
      if (event.event == AuthChangeEvent.signedOut ||
          event.event == AuthChangeEvent.passwordRecovery) {
        router.goNamed(Routes.login);
      }
    },
  );

  @override
  void initState() {
    _sreaming;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _sreaming.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Academic Fun',
      theme: ThemeData(
        fontFamily: "Urbanist",
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontFamily: "Urbanist",
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        useMaterial3: true,
      ),
    );
  }
}
