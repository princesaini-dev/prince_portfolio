import 'package:prince_portfolio/domain/firebase_services.dart';
import 'package:prince_portfolio/presentation/resources/string_manager.dart';
import 'package:prince_portfolio/utils/app_logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseClient {
  /// Get a reference your Supabase client
  static final instance = Supabase.instance.client;

  /// Initialize the Supabase client
  static Future<void> initializeDatabase() async {
    try {
      var firebaseService = FirebaseService();
      await firebaseService.initializeRemoteConfig();
      var supabaseUrl =
          firebaseService.remoteConfig.getString(StringManager.supabaseUrl);
      var supabaseAnanKey =
          firebaseService.remoteConfig.getString(StringManager.supabaseAnanKey);
      // await Supabase.initialize(
      //   url: supabaseUrl,
      //   anonKey: supabaseAnanKey,
      // );
      await Supabase.initialize(
        url: 'https://yeqvlzlkziaakzhkyrdh.supabase.co',
        anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InllcXZsemxremlhYWt6aGt5cmRoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDU5OTEzNzgsImV4cCI6MjA2MTU2NzM3OH0.sCXkASEqbrU4CVtPYVPzg-vnAqcohm0cGe_qA1PaHBQ',
      );
    } catch (e) {
      AppLogger.e("Error initializing Supabase client: $e");
    }
  }
}
