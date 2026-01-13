import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prince_portfolio/app/bloc_theme/theme_bloc.dart';
import 'package:prince_portfolio/app/bloc_theme/theme_bloc_event.dart';
import 'package:prince_portfolio/app/bloc_theme/thme_bloc_state.dart';
import 'package:prince_portfolio/presentation/dashboard/header/menu_items.dart';
import 'package:prince_portfolio/presentation/resources/color_manager.dart';
import 'package:prince_portfolio/utils/extention_context.dart';

class DrawerWidget extends StatefulWidget {
  final Function(int index) onMenuButtonPressed;
  const DrawerWidget({required this.onMenuButtonPressed, super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget>
    with TickerProviderStateMixin {
  late AnimationController _staggerController;
  late List<Animation<double>> _itemAnimations;
  late Animation<double> _headerAnimation;

  @override
  void initState() {
    super.initState();
    _staggerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _headerAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _staggerController,
        curve: const Interval(0, 0.3, curve: Curves.easeOutCubic),
      ),
    );

    _itemAnimations = List.generate(
      MenuItems.menuItems.length + 1,
      (index) => Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _staggerController,
          curve: Interval(
            0.2 + (index * 0.1),
            0.4 + (index * 0.1),
            curve: Curves.easeOutCubic,
          ),
        ),
      ),
    );

    _staggerController.forward();
  }

  @override
  void dispose() {
    _staggerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Drawer(
      width: context.width * .75,
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [
                        ColorManager.cardDark.withOpacity(0.95),
                        ColorManager.surfaceDark.withOpacity(0.98),
                      ]
                    : [
                        Colors.white.withOpacity(0.95),
                        ColorManager.surfaceLight.withOpacity(0.98),
                      ],
              ),
              border: Border(
                right: BorderSide(
                  color: ColorManager.accentPrimary.withOpacity(0.2),
                  width: 1,
                ),
              ),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  _buildHeader(context),
                  const SizedBox(height: 30),
                  _buildThemeToggle(context),
                  const SizedBox(height: 20),
                  Divider(
                    color: ColorManager.blackColor(context).withOpacity(0.1),
                    indent: 24,
                    endIndent: 24,
                  ),
                  const SizedBox(height: 10),
                  Expanded(child: _buildMenuItems(context)),
                  _buildFooter(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return AnimatedBuilder(
      animation: _headerAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(-30 * (1 - _headerAnimation.value), 0),
          child: Opacity(
            opacity: _headerAnimation.value,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: ColorManager.primaryGradient(context),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: ColorManager.glowShadow(context),
                    ),
                    child: const Icon(
                      Icons.code_rounded,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Portfolio',
                    style: TextStyle(
                      color: ColorManager.blackColor(context),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Navigate & Explore',
                    style: TextStyle(
                      color: ColorManager.blackColor(context).withOpacity(0.6),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildThemeToggle(BuildContext context) {
    final themeBloc = context.read<ThemeBloc>();
    final themeWatch = context.watch<ThemeBloc>();
    final isDark = themeWatch.state is! ThemeBlocStateLight;

    return AnimatedBuilder(
      animation: _itemAnimations[0],
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(-30 * (1 - _itemAnimations[0].value), 0),
          child: Opacity(
            opacity: _itemAnimations[0].value,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: GestureDetector(
                onTap: () {
                  themeBloc.add(ThemeEventLight(isLightTheme: isDark));
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark
                        ? ColorManager.accentPrimary.withOpacity(0.15)
                        : ColorManager.accentPrimary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: ColorManager.accentPrimary.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) {
                          return RotationTransition(
                            turns:
                                Tween(begin: 0.5, end: 1.0).animate(animation),
                            child:
                                ScaleTransition(scale: animation, child: child),
                          );
                        },
                        child: Icon(
                          isDark
                              ? Icons.dark_mode_rounded
                              : Icons.light_mode_rounded,
                          key: ValueKey(isDark),
                          color: ColorManager.accentPrimary,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          isDark ? 'Dark Mode' : 'Light Mode',
                          style: TextStyle(
                            color: ColorManager.blackColor(context),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: 48,
                        height: 28,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          gradient: isDark
                              ? ColorManager.primaryGradient(context)
                              : null,
                          color: isDark ? null : Colors.grey.shade300,
                        ),
                        child: AnimatedAlign(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          alignment: isDark
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            width: 22,
                            height: 22,
                            margin: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMenuItems(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: MenuItems.menuItems.length,
      itemBuilder: (context, index) {
        final item = MenuItems.menuItems[index];
        final animIndex = index + 1;
        return AnimatedBuilder(
          animation:
              _itemAnimations[animIndex.clamp(0, _itemAnimations.length - 1)],
          builder: (context, child) {
            final animValue =
                _itemAnimations[animIndex.clamp(0, _itemAnimations.length - 1)]
                    .value;
            return Transform.translate(
              offset: Offset(-40 * (1 - animValue), 0),
              child: Opacity(
                opacity: animValue,
                child: _DrawerMenuItem(
                  icon: item.icon,
                  title: item.title,
                  onTap: () {
                    Navigator.pop(context);
                    widget.onMenuButtonPressed(index);
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Text(
        '© 2024 Prince Portfolio',
        style: TextStyle(
          color: ColorManager.blackColor(context).withOpacity(0.4),
          fontSize: 12,
        ),
      ),
    );
  }
}

class _DrawerMenuItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _DrawerMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  State<_DrawerMenuItem> createState() => _DrawerMenuItemState();
}

class _DrawerMenuItemState extends State<_DrawerMenuItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: _isHovered
                  ? ColorManager.accentPrimary.withOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _isHovered
                    ? ColorManager.accentPrimary.withOpacity(0.3)
                    : Colors.transparent,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _isHovered
                        ? ColorManager.accentPrimary.withOpacity(0.2)
                        : ColorManager.blackColor(context).withOpacity(0.05),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    widget.icon,
                    size: 20,
                    color: _isHovered
                        ? ColorManager.accentPrimary
                        : ColorManager.blackColor(context).withOpacity(0.7),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    widget.title.toUpperCase(),
                    style: TextStyle(
                      color: _isHovered
                          ? ColorManager.accentPrimary
                          : ColorManager.blackColor(context),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: _isHovered ? 1 : 0,
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 14,
                    color: ColorManager.accentPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
