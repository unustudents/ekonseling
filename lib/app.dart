import 'package:flutter/material.dart';

import 'routes/app_pages.dart';
import 'supabase_config.dart';

class App extends StatelessWidget {
  const App({super.key});

  Future<void> _checkSession() async {
    final session = Supabase.instance.client.auth.currentSession;

    if (session != null) {
      // Sesi valid, cek apakah token masih berlaku
      final isTokenValid = await _isTokenStillValid(session);

      if (isTokenValid) {
        // Token valid, arahkan ke home
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomePage()),
        );
      } else {
        // Token kadaluarsa, clear session dan arahkan ke login
        await Supabase.instance.client.auth.signOut();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => LoginPage()),
        );
      }
    } else {
      // Tidak ada sesi, arahkan ke login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginPage()),
      );
    }
  }

  Future<bool> _isTokenStillValid(Session session) async {
    final expiresAt = session.expiresAt; // Waktu token expired (UTC timestamp)
    final currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    return currentTime < expiresAt!;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'E-Konseling',
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
              fontWeight: FontWeight.bold),
        ),
        useMaterial3: true,
      ),
    );
  }
}
