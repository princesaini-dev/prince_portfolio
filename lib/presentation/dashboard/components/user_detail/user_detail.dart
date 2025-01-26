import 'package:flutter/material.dart';
import 'package:prince_portfolio/data/portfolio_data_model.dart';
import 'package:prince_portfolio/presentation/dashboard/components/user_detail/hand_wave_animation.dart';
import 'package:prince_portfolio/presentation/dashboard/components/user_detail/welcome_animation.dart';
import 'package:prince_portfolio/presentation/resources/color_manager.dart';
import 'package:prince_portfolio/presentation/resources/image_manager.dart';
import 'package:prince_portfolio/utils/app_utills.dart';
import 'package:prince_portfolio/utils/extention_context.dart';
import 'package:prince_portfolio/utils/extention_images.dart';
import 'package:prince_portfolio/utils/responsive.dart';

class UserDetail extends StatelessWidget {
  final PortfolioDataModel portfolioDataModel;

  const UserDetail({required this.portfolioDataModel, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height,
      width: context.width,
      child: Responsive.isDesktop(context)
          ? _buildDesktopLayout(context)
          : _buildMobileLayout(context),
    );
  }

  /// **Mobile & Tablet Layout**
  Widget _buildMobileLayout(BuildContext context) {
    return Stack(
      children: [
        const Positioned(
            bottom: 0,
            right: 0,
            child: Padding(
                padding: EdgeInsets.all(12.0), child: WelcomeAnimation())),
        Center(child: _buildUserInfo(context)),
      ],
    );
  }

  /// **Desktop Layout**
  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1, child: _buildUserInfo(context)),
        const Expanded(flex: 1, child: WelcomeAnimation()),
      ],
    );
  }

  /// **User Information Section**
  Widget _buildUserInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 30),
            _buildUserName(context),
            const SizedBox(height: 30),
            _buildUserTitle(context),
            const SizedBox(height: 80),
            _buildSocialMediaLinks(context),
          ],
        ),
      ),
    );
  }

  /// **Header with Welcome Text & Animation**
  Widget _buildHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          portfolioDataModel.aboutMeDataModel?.welcomeText.toUpperCase() ?? "",
          style: _textStyle(context,
              fontSize: 18, letterSpacing: 6, fontWeight: FontWeight.w600),
        ),
        const HandWaveAnimation(),
      ],
    );
  }

  /// **User Name Display**
  Widget _buildUserName(BuildContext context) {
    return Text(
      portfolioDataModel.aboutMeDataModel?.fullName.toUpperCase() ?? "",
      style: _textStyle(context,
          fontSize: 52, letterSpacing: 2, fontWeight: FontWeight.bold),
    );
  }

  /// **User Title Display**
  Widget _buildUserTitle(BuildContext context) {
    return Text(
      portfolioDataModel.aboutMeDataModel?.title.toUpperCase() ?? "",
      style: _textStyle(context,
          fontSize: 18, letterSpacing: 2, fontWeight: FontWeight.w600),
    );
  }

  /// **Social Media Links Section**
  Widget _buildSocialMediaLinks(BuildContext context) {
    var socialLinks = [];
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: socialLinks.map((link) {
        return Padding(
          padding: EdgeInsets.only(
              right: Responsive.isDesktop(context) ? 80.0 : 30.0),
          child: _buildSocialMediaButton(context, link.icon, link.url),
        );
      }).toList(),
    );
  }

  /// **Single Social Media Button**
  Widget _buildSocialMediaButton(
      BuildContext context, String icon, String url) {
    return IconButton(
      hoverColor: ColorManager.blackColor(context).withOpacity(0.5),
      icon: icon.loadImages(
          color: ColorManager.blackColor(context), height: 40, width: 40),
      onPressed: () => AppUtills.loadUrl(url),
    );
  }

  /// **Reusable Text Style**
  TextStyle _textStyle(BuildContext context,
      {double fontSize = 16,
      double letterSpacing = 1,
      FontWeight fontWeight = FontWeight.normal}) {
    return TextStyle(
      color: ColorManager.blackColor(context),
      letterSpacing: letterSpacing,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }
}
