import 'package:ekonseling/features/auth/presentation/pages/login_screen.dart';
import 'package:ekonseling/features/auth/presentation/pages/register_screen.dart';
import 'package:flutter/material.dart';

import 'features/auth/presentation/pages/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Konseling',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        primarySwatch: Colors.blue,
        fontFamily: "Urbanist",
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(color: Colors.black, fontFamily: "Urbanist", fontSize: 15, fontWeight: FontWeight.bold),
          // backgroundColor: Colors.white,
          // elevation: 0,
          // iconTheme: IconThemeData(color: Colors.black),
        ),
        useMaterial3: true,
      ),
      home: const RegisterScreen(),
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
