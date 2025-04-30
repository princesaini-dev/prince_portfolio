import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:prince_portfolio/app/app.dart';
import 'package:prince_portfolio/supabase_client.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SupabaseClient.initializeDatabase();
  runApp(const MyApp());
}
