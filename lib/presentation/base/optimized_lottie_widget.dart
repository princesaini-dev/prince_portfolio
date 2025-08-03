import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../utils/performance_utils.dart';

class OptimizedLottieWidget extends StatefulWidget {
  final String animationPath;
  final double? width;
  final double? height;
  final bool repeat;
  final bool reverse;
  final bool animate;
  final BoxFit fit;
  final Duration? duration;
  final VoidCallback? onLoaded;
  final bool enableLazyLoading;

  const OptimizedLottieWidget({
    super.key,
    required this.animationPath,
    this.width,
    this.height,
    this.repeat = true,
    this.reverse = false,
    this.animate = true,
    this.fit = BoxFit.contain,
    this.duration,
    this.onLoaded,
    this.enableLazyLoading = true,
  });

  @override
  State<OptimizedLottieWidget> createState() => _OptimizedLottieWidgetState();
}

class _OptimizedLottieWidgetState extends State<OptimizedLottieWidget>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  bool _isVisible = false;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    if (!widget.enableLazyLoading) {
      _initializeAnimation();
    }
  }

  void _initializeAnimation() {
    if (_controller != null) return;

    _controller = PerformanceUtils.createOptimizedAnimationController(
      vsync: this,
      duration: widget.duration ??
          PerformanceUtils.getOptimalAnimationDuration(
            const Duration(milliseconds: 1500)
          ),
    );

    if (widget.animate && _isVisible) {
      _startAnimation();
    }
  }

  void _startAnimation() {
    if (_controller == null) return;

    if (widget.repeat) {
      _controller!.repeat(reverse: widget.reverse);
    } else {
      _controller!.forward();
    }
  }

  void _stopAnimation() {
    _controller?.stop();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.enableLazyLoading) {
      return VisibilityDetector(
        key: Key('lottie_${widget.animationPath}'),
        onVisibilityChanged: (visibilityInfo) {
          final isVisible = visibilityInfo.visibleFraction > 0.1;

          if (isVisible != _isVisible) {
            setState(() {
              _isVisible = isVisible;
            });

            if (isVisible && !_isLoaded) {
              _initializeAnimation();
              _isLoaded = true;
            }

            if (widget.animate) {
              if (isVisible) {
                _startAnimation();
              } else {
                _stopAnimation();
              }
            }
          }
        },
        child: _buildLottieWidget(),
      );
    } else {
      return _buildLottieWidget();
    }
  }

  Widget _buildLottieWidget() {
    if (widget.enableLazyLoading && !_isVisible) {
      return SizedBox(
        width: widget.width,
        height: widget.height,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    }

    return RepaintBoundary(
      child: Lottie.asset(
        widget.animationPath,
        controller: _controller,
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
        repeat: false, // We handle repeat with controller
        reverse: false, // We handle reverse with controller
        animate: false, // We handle animation with controller
        onLoaded: (composition) {
          if (widget.onLoaded != null) {
            widget.onLoaded!();
          }

          if (widget.duration == null && _controller != null) {
            _controller!.duration = composition.duration;
          }

          if (widget.animate && (_isVisible || !widget.enableLazyLoading)) {
            _startAnimation();
          }
        },
        options: LottieOptions(
          enableMergePaths: true, // Optimize rendering
        ),
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.animation,
              color: Colors.grey,
            ),
          );
        },
      ),
    );
  }
}
