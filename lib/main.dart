import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/task/presentation/bloc/task_bloc.dart';
import 'routes/app_pages.dart';
import 'supabase_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await SupabaseConfig.initialize();

  runApp(MyApp());
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
        if (event.event == AuthChangeEvent.signedOut ||
            event.event == AuthChangeEvent.passwordRecovery) {
          router.goNamed(Routes.login);
        }

        if (event.event == AuthChangeEvent.initialSession) {
          router.goNamed(Routes.home);
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AuthBloc()..add(AuthCheckRequested())),
        BlocProvider(create: (context) => TaskBloc()),
      ],
      child: App(),
    );
  }
}
