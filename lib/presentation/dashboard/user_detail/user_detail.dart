import 'package:flutter/material.dart';
import 'package:prince_portfolio/presentation/dashboard/user_detail/hand_wave_animation.dart';
import 'package:prince_portfolio/presentation/dashboard/user_detail/welcome_animation.dart';
import 'package:prince_portfolio/presentation/resources/color_manager.dart';
import 'package:prince_portfolio/presentation/resources/string_manager.dart';
import 'package:prince_portfolio/utils/extention_context.dart';

class UserDetail extends StatelessWidget {
  const UserDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * .9,
      width: context.width,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        StringManager.welcomeToMyPortfolio.toUpperCase(),
                        style: TextStyle(
                            color: ColorManager.blackColor(context),
                            letterSpacing: 4,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      const HandWaveAnimation()
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    StringManager.princeSaini.toUpperCase(),
                    style: TextStyle(
                        color: ColorManager.blackColor(context),
                        letterSpacing: 6,
                        fontSize: 48,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
          const Expanded(flex: 1, child: WelcomeAnimation())
        ],
      ),
    );
  }
}
