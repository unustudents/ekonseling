import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'routes/app_pages.dart';
import 'supabase_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await SupabaseConfig.initialize();

  runApp(
    // DevicePreview(
    //   enabled: !kReleaseMode && kIsWeb,
    //   builder: (BuildContext context) => const MyApp(),
    // ),
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    SupabaseConfig.client.auth.onAuthStateChange.listen(
      (event) {
        if (event.event == AuthChangeEvent.signedOut) {
          print('onAuthStateChange: signedOut');
          router.goNamed(Routes.login);
        }
        ;
        if (event.event == AuthChangeEvent.signedIn) print('onAuthStateChange: signedIn');
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()..add(AuthCheckRequested())),
      ],
      child: MaterialApp.router(
        // locale: DevicePreview.locale(context),
        // builder: DevicePreview.appBuilder,
        routerConfig: router,
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
      ),
    );
  }
}
