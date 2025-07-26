import 'package:flutter/material.dart';
import 'package:prince_portfolio/utils/app_logger.dart';

import '../app_root.dart';
import '../supabase_client.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<void> _initializeServices() async {
    try {
      await SupabaseClient.initializeDatabase();
    } catch (error) {
      AppLogger.e(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeServices(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return const AppRoot();
        } else if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Center(child: Text('Init Error: ${snapshot.error}')),
            ),
          );
        } else {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ), // Optional custom loader
          );
        }
      },
    );
  }
}
