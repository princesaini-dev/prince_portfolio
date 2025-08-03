import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:prince_portfolio/app/app.dart';

Future<void> main() async {
  // Minimal binding initialization for faster startup
  WidgetsFlutterBinding.ensureInitialized();

  // Only set orientations on mobile platforms
  if (!kIsWeb) {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  // Optimize for web performance
  if (kIsWeb) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
  }

  // Start app immediately without waiting for heavy initialization
  runApp(const MyApp());
}
