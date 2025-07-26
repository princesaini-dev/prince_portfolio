import 'package:prince_portfolio/utils/app_logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseClient {
  static bool _isInitialized = false;

  /// Get a reference to your Supabase client
  static final instance = Supabase.instance.client;

  /// Initialize the Supabase client
  static Future<void> initializeDatabase() async {
    if (_isInitialized) {
      return;
    }

    try {
      await Supabase.initialize(
        url: 'https://yeqvlzlkziaakzhkyrdh.supabase.co',
        anonKey:
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InllcXZsemxremlhYWt6aGt5cmRoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDU5OTEzNzgsImV4cCI6MjA2MTU2NzM3OH0.sCXkASEqbrU4CVtPYVPzg-vnAqcohm0cGe_qA1PaHBQ',
        authOptions: const FlutterAuthClientOptions(
          authFlowType: AuthFlowType.pkce,
        ),
      );
      _isInitialized = true;
    } catch (e) {
      AppLogger.e("Error initializing Supabase client: $e");
    }
  }
}
