import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:prince_portfolio/app/app.dart';
import 'package:prince_portfolio/firebase_options.dart';

Future<void> main() async {
  // Minimal binding initialization for faster startup
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
