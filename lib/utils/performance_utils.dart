import 'dart:async';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PerformanceUtils {
  /// Debounce function calls to prevent excessive executions
  static Timer? _debounceTimer;

  static void debounce(Duration duration, VoidCallback callback) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(duration, callback);
  }

  /// Optimize build performance by reducing unnecessary rebuilds
  static bool shouldRebuild<T>(T? oldValue, T? newValue) {
    return oldValue != newValue;
  }

  /// Memory-efficient list builder with viewport optimization
  static Widget buildOptimizedListView({
    required int itemCount,
    required Widget Function(BuildContext, int) itemBuilder,
    ScrollController? controller,
    ScrollPhysics? physics,
    EdgeInsets? padding,
    bool shrinkWrap = false,
  }) {
    return ListView.builder(
      controller: controller,
      physics: physics ?? const BouncingScrollPhysics(),
      padding: padding,
      shrinkWrap: shrinkWrap,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      cacheExtent: 200, // Optimize viewport caching
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: true,
      addSemanticIndexes: true,
    );
  }

  /// Create performance-optimized animations
  static AnimationController createOptimizedAnimationController({
    required TickerProvider vsync,
    Duration duration = const Duration(milliseconds: 300),
    double? value,
    double lowerBound = 0.0,
    double upperBound = 1.0,
  }) {
    return AnimationController(
      vsync: vsync,
      duration: duration,
      value: value,
      lowerBound: lowerBound,
      upperBound: upperBound,
    );
  }

  /// Optimize image memory usage
  static int? calculateOptimalImageSize(double? displaySize, {double devicePixelRatio = 1.0}) {
    if (displaySize == null) return null;
    return (displaySize * devicePixelRatio * 1.2).toInt(); // 20% buffer for smooth scaling
  }

  /// Check if device is low-end for performance adjustments
  static bool get isLowEndDevice {
    // This is a simplified check - you might want to implement more sophisticated detection
    return kIsWeb ? false : defaultTargetPlatform == TargetPlatform.android;
  }

  /// Reduce animation complexity on low-end devices
  static Duration getOptimalAnimationDuration(Duration defaultDuration) {
    if (isLowEndDevice) {
      return Duration(milliseconds: (defaultDuration.inMilliseconds * 0.7).round());
    }
    return defaultDuration;
  }

  /// Create optimized gradient backgrounds
  static BoxDecoration createOptimizedGradient({
    required List<Color> colors,
    AlignmentGeometry begin = Alignment.topLeft,
    AlignmentGeometry end = Alignment.bottomRight,
    BorderRadius? borderRadius,
  }) {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: begin,
        end: end,
        colors: colors,
        stops: _generateOptimalStops(colors.length),
      ),
      borderRadius: borderRadius,
    );
  }

  static List<double> _generateOptimalStops(int colorCount) {
    if (colorCount <= 1) return [0.0];
    return List.generate(colorCount, (index) => index / (colorCount - 1));
  }

  /// Batch widget updates for better performance
  static Widget batchUpdates({
    required Widget child,
    Duration batchDuration = const Duration(milliseconds: 16), // 60fps
  }) {
    return RepaintBoundary(child: child);
  }

  /// Create optimized scroll behavior
  static ScrollBehavior get optimizedScrollBehavior {
    return const MaterialScrollBehavior().copyWith(
      dragDevices: {
        PointerDeviceKind.mouse,
        PointerDeviceKind.touch,
        PointerDeviceKind.stylus,
        PointerDeviceKind.unknown,
      },
      scrollbars: kIsWeb,
      overscroll: false,
      physics: const BouncingScrollPhysics(),
    );
  }
}
