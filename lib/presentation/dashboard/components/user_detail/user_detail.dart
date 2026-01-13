import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:prince_portfolio/data/portfolio_data_model.dart';
import 'package:prince_portfolio/presentation/dashboard/components/user_detail/hand_wave_animation.dart';
import 'package:prince_portfolio/presentation/dashboard/components/user_detail/welcome_animation.dart';
import 'package:prince_portfolio/presentation/resources/color_manager.dart';
import 'package:prince_portfolio/utils/app_utills.dart';
import 'package:prince_portfolio/utils/extention_context.dart';
import 'package:prince_portfolio/utils/responsive.dart';

class UserDetail extends StatefulWidget {
  final PortfolioDataModel portfolioDataModel;

  const UserDetail({required this.portfolioDataModel, super.key});

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late List<Animation<double>> _staggeredAnimations;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );

    _staggeredAnimations = List.generate(
      7,
      (index) => Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _slideController,
          curve: Interval(
            index * 0.1,
            0.4 + (index * 0.1),
            curve: Curves.easeOutCubic,
          ),
        ),
      ),
    );

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height,
      width: context.width,
      decoration: BoxDecoration(
        gradient: ColorManager.backgroundGradient(context),
      ),
      child: Stack(
        children: [
          _buildBackgroundElements(context),
          Responsive.isDesktop(context)
              ? _buildDesktopLayout(context)
              : _buildMobileLayout(context),
        ],
      ),
    );
  }

  Widget _buildBackgroundElements(BuildContext context) {
    return Positioned.fill(
      child: AnimatedBuilder(
        animation: _fadeAnimation,
        builder: (context, child) {
          return Opacity(
            opacity: _fadeAnimation.value * 0.5,
            child: Stack(
              children: [
                Positioned(
                  top: -100,
                  right: -100,
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          ColorManager.accentPrimary.withOpacity(0.15),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -50,
                  left: -50,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          ColorManager.accentSecondary.withOpacity(0.1),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          right: 0,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: const Padding(
              padding: EdgeInsets.all(12.0),
              child: WelcomeAnimation(),
            ),
          ),
        ),
        Center(child: _buildUserInfo(context)),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1, child: _buildUserInfo(context)),
        Expanded(
          flex: 1,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: const WelcomeAnimation(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserInfo(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Responsive.isMobile(context) ? 24 : 50),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildAnimatedItem(0, _buildHeader(context)),
            const SizedBox(height: 24),
            _buildAnimatedItem(1, _buildUserName(context)),
            const SizedBox(height: 16),
            _buildAnimatedItem(2, _buildUserTitle(context)),
            const SizedBox(height: 32),
            _buildAnimatedItem(3, _buildUserEmail(context)),
            const SizedBox(height: 12),
            _buildAnimatedItem(4, _buildUserLocation(context)),
            const SizedBox(height: 48),
            _buildAnimatedItem(5, _buildSocialMediaLinks(context)),
            const SizedBox(height: 40),
            _buildAnimatedItem(6, _buildCTAButton(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedItem(int index, Widget child) {
    return AnimatedBuilder(
      animation: _staggeredAnimations[index],
      builder: (context, _) {
        return Transform.translate(
          offset: Offset(-30 * (1 - _staggeredAnimations[index].value), 0),
          child: Opacity(
            opacity: _staggeredAnimations[index].value,
            child: child,
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorManager.accentPrimary.withOpacity(0.15),
            ColorManager.accentSecondary.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: ColorManager.accentPrimary.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const HandWaveAnimation(),
          const SizedBox(width: 8),
          Text(
            widget.portfolioDataModel.aboutMeDataModel?.welcomeText ?? "Hello!",
            style: TextStyle(
              color: ColorManager.blackColor(context),
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserName(BuildContext context) {
    final name = widget.portfolioDataModel.aboutMeDataModel?.fullName ?? "";
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [
          ColorManager.blackColor(context),
          ColorManager.blackColor(context).withOpacity(0.8),
        ],
      ).createShader(bounds),
      child: Text(
        name.toUpperCase(),
        style: TextStyle(
          color: ColorManager.blackColor(context),
          fontSize: Responsive.isMobile(context) ? 36 : 56,
          fontWeight: FontWeight.bold,
          letterSpacing: -1,
          height: 1.1,
        ),
      ),
    );
  }

  Widget _buildUserTitle(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 3,
            decoration: BoxDecoration(
              gradient: ColorManager.primaryGradient(context),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              widget.portfolioDataModel.aboutMeDataModel?.title ?? "",
              style: TextStyle(
                color: ColorManager.accentPrimary,
                fontSize: Responsive.isMobile(context) ? 16 : 20,
                fontWeight: FontWeight.w600,
                letterSpacing: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserEmail(BuildContext context) {
    return _buildInfoRow(
      context,
      Icons.email_rounded,
      widget.portfolioDataModel.aboutMeDataModel?.email ?? "",
    );
  }

  Widget _buildUserLocation(BuildContext context) {
    return _buildInfoRow(
      context,
      Icons.location_on_rounded,
      widget.portfolioDataModel.aboutMeDataModel?.location ?? "",
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: ColorManager.accentPrimary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: ColorManager.accentPrimary,
            size: 18,
          ),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            text,
            style: TextStyle(
              color: ColorManager.blackColor(context).withOpacity(0.8),
              fontSize: 15,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialMediaLinks(BuildContext context) {
    var socialLinks = widget.portfolioDataModel.socialMediaDataModel ?? [];
    return Wrap(
      spacing: 16,
      runSpacing: 12,
      children: socialLinks.map((link) {
        return _SocialButton(
          imageUrl: link.imageUrl,
          name: link.name,
          link: link.link,
        );
      }).toList(),
    );
  }

  Widget _buildCTAButton(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          // Scroll to contact section
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          decoration: BoxDecoration(
            gradient: ColorManager.primaryGradient(context),
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: ColorManager.accentPrimary.withOpacity(0.4),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Get In Touch',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String link;

  const _SocialButton({
    required this.imageUrl,
    required this.name,
    required this.link,
  });

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    if (widget.imageUrl.isEmpty) return const SizedBox.shrink();

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => AppUtills.loadUrl(widget.link),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _isHovered
                ? ColorManager.accentPrimary.withOpacity(0.15)
                : ColorManager.blackColor(context).withOpacity(0.05),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _isHovered
                  ? ColorManager.accentPrimary.withOpacity(0.4)
                  : Colors.transparent,
              width: 1.5,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: ColorManager.accentPrimary.withOpacity(0.2),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ]
                : null,
          ),
          child: AnimatedScale(
            scale: _isHovered ? 1.1 : 1.0,
            duration: const Duration(milliseconds: 200),
            child: Image.network(
              widget.imageUrl,
              color: _isHovered
                  ? ColorManager.accentPrimary
                  : ColorManager.blackColor(context),
              height: 28,
              width: 28,
            ),
          ),
        ),
      ),
    );
  }
}
