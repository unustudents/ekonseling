import 'package:device_preview/device_preview.dart';
import 'package:ekonseling/navigation_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
    return MaterialApp(
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
      // home: const ProfileScreen(),
      home: BlocProvider(create: (_) => NavigationCubit(), child: const AppScreen()),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // buatkan snackbar
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Hello, I am a SnackBar!'),
              ),
            );
          },
          child: const Text('Go to Second Page'),
        ),
      ),
    );
  }
}
