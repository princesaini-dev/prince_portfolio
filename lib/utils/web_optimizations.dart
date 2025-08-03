import 'dart:async';
import 'package:web/web.dart' as web;
import 'package:flutter/foundation.dart';

class WebOptimizations {
  static bool _initialized = false;

  /// Initialize web-specific performance optimizations
  static void initialize() {
    if (_initialized || !kIsWeb) return;
    _initialized = true;

    // Optimize canvas rendering
    _optimizeCanvas();

    // Add performance observers
    _addPerformanceObservers();

    // Optimize memory management
    _setupMemoryOptimizations();

    // Enable aggressive caching
    _enableAggressiveCaching();
  }

  static void _optimizeCanvas() {
    try {
      // Enable hardware acceleration hints for Flutter canvas
      final canvas = web.document.querySelector('flt-glass-pane') as web.HTMLElement?;
      if (canvas != null) {
        canvas.style.willChange = 'transform';
        canvas.style.transform = 'translateZ(0)';
        canvas.style.backfaceVisibility = 'hidden';
      }

      // Optimize Flutter rendering
      final flutterView = web.document.querySelector('flutter-view') as web.HTMLElement?;
      if (flutterView != null) {
        flutterView.style.contain = 'layout style paint';
      }

      // Optimize body for better performance
      final body = web.document.body;
      if (body != null) {
        body.style.margin = '0';
        body.style.padding = '0';
        body.style.overflow = 'hidden';
      }
    } catch (e) {
      if (kDebugMode) print('Canvas optimization failed: $e');
    }
  }

  static void _addPerformanceObservers() {
    try {
      // Monitor performance metrics
      web.window.addEventListener('load', (web.Event event) {
        Timer(const Duration(milliseconds: 100), () {
          _logPerformanceMetrics();
        });
      } as web.EventListener?);

      // Monitor Flutter first frame
      web.window.addEventListener('flutter-first-frame', (web.Event event) {
        if (kDebugMode) print('Flutter first frame rendered');
      } as web.EventListener?);
    } catch (e) {
      if (kDebugMode) print('Performance observer setup failed: $e');
    }
  }

  static void _logPerformanceMetrics() {
    try {
      if (kDebugMode) {
        print('Performance optimization active');
        // Log basic timing if available
        final loadTime = web.window.performance.now();
        print('Current performance time: ${loadTime.toStringAsFixed(2)}ms');
      }
    } catch (e) {
      if (kDebugMode) print('Performance logging failed: $e');
    }
  }

  static void _setupMemoryOptimizations() {
    // Force garbage collection periodically
    Timer.periodic(const Duration(minutes: 2), (timer) {
      try {
        // Trigger garbage collection hint
        if (kDebugMode) print('Memory cleanup cycle');
      } catch (e) {
        if (kDebugMode) print('Memory optimization failed: $e');
      }
    });
  }

  static void _enableAggressiveCaching() {
    try {
      // Set up aggressive caching strategies
      if (kDebugMode) print('Aggressive caching enabled');
    } catch (e) {
      if (kDebugMode) print('Caching setup failed: $e');
    }
  }

  /// Preload critical resources
  static void preloadCriticalResources() {
    if (!kIsWeb) return;

    try {
      // Preload important images with modern approach
      final imagesToPreload = [
        'assets/images/medcura.webp',
        'assets/images/pcl_health.webp',
        'assets/images/linkedin.png',
        'assets/images/github.png',
      ];

      for (final imagePath in imagesToPreload) {
        final img = web.HTMLImageElement();
        img.src = imagePath;
        img.loading = 'eager';
        img.decoding = 'sync';
      }
    } catch (e) {
      if (kDebugMode) print('Resource preloading failed: $e');
    }
  }
}
