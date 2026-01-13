import 'package:flutter/material.dart';
import 'package:prince_portfolio/data/portfolio_data_model.dart';
import 'package:prince_portfolio/presentation/dashboard/components/about_me/question_mark_animation.dart';
import 'package:prince_portfolio/presentation/resources/color_manager.dart';
import 'package:prince_portfolio/presentation/resources/string_manager.dart';
import 'package:prince_portfolio/utils/extention_context.dart';
import 'package:prince_portfolio/utils/responsive.dart';

class AboutMe extends StatefulWidget {
  final PortfolioDataModel portfolioDataModel;

  const AboutMe({required this.portfolioDataModel, super.key});

  @override
  State<AboutMe> createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOut),
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorManager.whiteColor(context),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.isMobile(context) ? 20 : 60,
          vertical: 80,
        ),
        child: Column(
          children: [
            _buildSectionHeader(context),
            const SizedBox(height: 60),
            Responsive.isDesktop(context)
                ? _desktopWidget(context)
                : _mobileTabWidget(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: ColorManager.accentPrimary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'ABOUT',
              style: TextStyle(
                color: ColorManager.accentPrimary,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
              ),
            ),
          ),
          const SizedBox(height: 16),
          ShaderMask(
            shaderCallback: (bounds) =>
                ColorManager.primaryGradient(context).createShader(bounds),
            child: Text(
              StringManager.aboutMe,
              style: TextStyle(
                color: Colors.white,
                fontSize: Responsive.isMobile(context) ? 32 : 42,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            StringManager.getToKnowMe,
            style: TextStyle(
              color: ColorManager.blackColor(context).withOpacity(0.6),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _desktopWidget(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: ColorManager.cardColor(context),
                borderRadius: BorderRadius.circular(24),
                boxShadow: ColorManager.cardShadow(context),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  QuestionMarkAnimation(width: context.width * .15),
                  const SizedBox(height: 24),
                  Text(
                    StringManager.whoAmI,
                    style: TextStyle(
                      color: ColorManager.accentPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 40),
          Expanded(
            flex: 3,
            child: _descriptionWidget(context),
          ),
        ],
      ),
    );
  }

  Widget _mobileTabWidget(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: ColorManager.cardColor(context),
              borderRadius: BorderRadius.circular(20),
              boxShadow: ColorManager.cardShadow(context),
            ),
            child: QuestionMarkAnimation(width: context.width * .4),
          ),
          const SizedBox(height: 40),
          _descriptionWidget(context),
        ],
      ),
    );
  }

  Widget _descriptionWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Responsive.isMobile(context) ? 24 : 40),
      decoration: BoxDecoration(
        color: ColorManager.cardColor(context),
        borderRadius: BorderRadius.circular(24),
        boxShadow: ColorManager.cardShadow(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIntroSection(context),
          const SizedBox(height: 32),
          _buildDivider(context),
          const SizedBox(height: 32),
          _buildTechSection(context),
        ],
      ),
    );
  }

  Widget _buildIntroSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 24,
              decoration: BoxDecoration(
                gradient: ColorManager.primaryGradient(context),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Text(
                widget.portfolioDataModel.aboutMeDataModel?.introTitle ?? '',
                softWrap: true,
                maxLines: null,
                style: TextStyle(
                  color: ColorManager.blackColor(context),
                  fontSize: Responsive.isMobile(context) ? 20 : 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.3,
                  height: 1.2, // Optional: improves line spacing
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          widget.portfolioDataModel.aboutMeDataModel?.objective ?? '',
          style: TextStyle(
            color: ColorManager.blackColor(context).withOpacity(0.75),
            fontSize: 15,
            height: 1.8,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Container(
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            ColorManager.blackColor(context).withOpacity(0.1),
            ColorManager.accentPrimary.withOpacity(0.3),
            ColorManager.blackColor(context).withOpacity(0.1),
            Colors.transparent,
          ],
        ),
      ),
    );
  }

  Widget _buildTechSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: ColorManager.accentPrimary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.code_rounded,
                color: ColorManager.accentPrimary,
                size: 20,
              ),
            ),
            const SizedBox(width: 14),
            Text(
              StringManager.technologyWorkedWith,
              style: TextStyle(
                color: ColorManager.blackColor(context),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _technologyWidget(context),
      ],
    );
  }

  Widget _technologyWidget(BuildContext context) {
    var technologies = widget.portfolioDataModel.technologiesDataModel ?? [];
    technologies
        .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: technologies.map((item) {
        return _TechChip(name: item.name);
      }).toList(),
    );
  }
}

class _TechChip extends StatefulWidget {
  final String name;

  const _TechChip({required this.name});

  @override
  State<_TechChip> createState() => _TechChipState();
}

class _TechChipState extends State<_TechChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: _isHovered
              ? ColorManager.accentPrimary.withOpacity(0.15)
              : ColorManager.blackColor(context).withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isHovered
                ? ColorManager.accentPrimary.withOpacity(0.4)
                : Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _isHovered
                    ? ColorManager.accentPrimary
                    : ColorManager.accentPrimary.withOpacity(0.5),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              widget.name,
              style: TextStyle(
                color: _isHovered
                    ? ColorManager.accentPrimary
                    : ColorManager.blackColor(context).withOpacity(0.8),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
