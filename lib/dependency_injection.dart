import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';

final getIt = GetIt.instance;

class DependencyInjection {
  static Future<void> init() async {
    // Register FirebaseAuth instance
    getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

    // Tambahkan dependency lain di sini (contoh: repository, database, dsb.)
  }
}
