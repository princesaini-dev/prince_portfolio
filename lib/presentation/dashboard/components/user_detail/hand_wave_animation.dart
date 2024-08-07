import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:prince_portfolio/presentation/resources/animation_manager.dart';

class HandWaveAnimation extends StatelessWidget {
  const HandWaveAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      height: 45,
      width: 45,
      AnimationManager.handWave,
      fit: BoxFit.contain,
    );
  }
}
