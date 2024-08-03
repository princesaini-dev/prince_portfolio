import 'package:flutter/material.dart';
import 'package:prince_portfolio/presentation/dashboard/user_detail/hand_wave_animation.dart';
import 'package:prince_portfolio/presentation/dashboard/user_detail/welcome_animation.dart';
import 'package:prince_portfolio/presentation/resources/color_manager.dart';
import 'package:prince_portfolio/presentation/resources/image_manager.dart';
import 'package:prince_portfolio/presentation/resources/string_manager.dart';
import 'package:prince_portfolio/utils/app_utills.dart';
import 'package:prince_portfolio/utils/extention_context.dart';
import 'package:prince_portfolio/utils/extention_images.dart';

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
              child: SingleChildScrollView(
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
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    _socialMediaLinks(context)
                  ],
                ),
              ),
            ),
          ),
          const Expanded(flex: 1, child: WelcomeAnimation())
        ],
      ),
    );
  }

  Widget _socialMediaLinks(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _socialItemView(
          context,
          ImageManager.iconLinkedin,
          onPressed: () {
            AppUtills.loadUrl(StringManager.linkedinUrl);
          },
        ),
        _socialItemView(
          context,
          ImageManager.iconGithub,
          onPressed: () {
            AppUtills.loadUrl(StringManager.githubUrl);
          },
        ),
        _socialItemView(
          context,
          ImageManager.iconInstagram,
          onPressed: () {
            AppUtills.loadUrl(StringManager.instagramUrl);
          },
        )
      ],
    );
  }

  Widget _socialItemView(BuildContext context, String icon,
      {required Function() onPressed}) {
    return IconButton(
      hoverColor: ColorManager.blackColor(context).withOpacity(0.5),
      icon: icon.loadImages(
          color: ColorManager.blackColor(context), height: 40, width: 40),
      onPressed: onPressed,
    );
  }
}
