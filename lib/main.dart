import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/task/presentation/bloc/task_bloc.dart';
import 'supabase_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await SupabaseConfig.initialize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        // BlocProvider(create: (context) => TaskBloc()),
      ],
      child: App(),
    );
  }
}
