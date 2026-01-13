import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:prince_portfolio/app/app.dart';
import 'package:prince_portfolio/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
