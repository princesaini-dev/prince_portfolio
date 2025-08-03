import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class LazyLoadWidget extends StatefulWidget {
  final Widget child;
  final Widget? placeholder;
  final double visibilityFraction;
  final Duration delay;

  const LazyLoadWidget({
    super.key,
    required this.child,
    this.placeholder,
    this.visibilityFraction = 0.1,
    this.delay = const Duration(milliseconds: 100),
  });

  @override
  State<LazyLoadWidget> createState() => _LazyLoadWidgetState();
}

class _LazyLoadWidgetState extends State<LazyLoadWidget> {
  bool _isVisible = false;
  bool _hasLoaded = false;

  @override
  Widget build(BuildContext context) {
    if (_hasLoaded) {
      return widget.child;
    }

    return VisibilityDetector(
      key: Key(widget.hashCode.toString()),
      onVisibilityChanged: (info) {
        if (!_hasLoaded && info.visibleFraction >= widget.visibilityFraction) {
          setState(() {
            _isVisible = true;
          });

          Future.delayed(widget.delay, () {
            if (mounted && _isVisible) {
              setState(() {
                _hasLoaded = true;
              });
            }
          });
        }
      },
      child: widget.placeholder ??
        SizedBox(
          height: 200,
          child: Container(
            color: Colors.grey[100],
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
    );
  }
}
