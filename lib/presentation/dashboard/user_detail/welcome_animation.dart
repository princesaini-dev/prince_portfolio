import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:prince_portfolio/presentation/resources/animation_manager.dart';
import 'package:prince_portfolio/utils/extention_context.dart';

class WelcomeAnimation extends StatelessWidget {
  const WelcomeAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.height * .18),
      child: Lottie.asset(
        AnimationManager.welcomeAnimation,
        fit: BoxFit.contain,
      ),
    );
  }
}
