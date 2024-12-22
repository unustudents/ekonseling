import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SupabaseConfig {
  static Future<void> initialize() async {
    try {
      await dotenv.load(fileName: ".env"); // Load .env file
      await Supabase.initialize(
        url: dotenv.env['SUPABASE_URL']!,
        anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
      );
    } catch (e) {
      print("Error initializing Supabase: $e");
    }
  }

  static SupabaseClient get client => Supabase.instance.client;
}
