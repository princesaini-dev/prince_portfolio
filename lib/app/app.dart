import 'package:flutter/material.dart';
import 'package:prince_portfolio/utils/app_logger.dart';
import 'package:shimmer/shimmer.dart';

import '../app_root.dart';
import '../supabase_client.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isInitialized = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initializeServices();
  }

  Future<void> _initializeServices() async {
    try {
      // Non-blocking initialization - start app first, then initialize services
      await Future.delayed(const Duration(milliseconds: 100));
      await SupabaseClient.initializeDatabase();
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    } catch (error) {
      AppLogger.e(error);
      if (mounted) {
        setState(() {
          _error = error.toString();
          _isInitialized = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: _buildLoadingScreen(),
        ),
      );
    } else if (_error != null) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text('Initialization Error: $_error'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isInitialized = false;
                      _error = null;
                    });
                    _initializeServices();
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return const AppRoot();
    }
  }

  Widget _buildLoadingScreen() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF667eea), Color(0xFF764ba2)],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Shimmer.fromColors(
              baseColor: Colors.white54,
              highlightColor: Colors.white,
              child: const Text(
                'Prince Portfolio',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 32),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
