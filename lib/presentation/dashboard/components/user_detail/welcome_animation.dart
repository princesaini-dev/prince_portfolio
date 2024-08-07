import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:prince_portfolio/presentation/resources/animation_manager.dart';
import 'package:prince_portfolio/utils/extention_context.dart';
import 'package:prince_portfolio/utils/responsive.dart';

class WelcomeAnimation extends StatelessWidget {
  const WelcomeAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: Responsive.isDesktop(context) ? 1 : .3,
      child: Center(
        child: Lottie.asset(
          height: context.height * .7,
          AnimationManager.welcomeAnimation,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
