import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prince_portfolio/app/bloc_theme/theme_bloc.dart';
import 'package:prince_portfolio/app/bloc_theme/theme_bloc_event.dart';
import 'package:prince_portfolio/app/bloc_theme/thme_bloc_state.dart';
import 'package:prince_portfolio/presentation/dashboard/header/menu_items.dart';
import 'package:prince_portfolio/presentation/resources/color_manager.dart';
import 'package:prince_portfolio/utils/responsive.dart';

class DashboardHeader extends StatefulWidget implements PreferredSizeWidget {
  final Function() onMenuButtonPressed;
  final Function(int index) onOptionClick;
  const DashboardHeader(
      {required this.onMenuButtonPressed,
      required this.onOptionClick,
      super.key});

  @override
  State<DashboardHeader> createState() => _DashboardHeaderState();

  @override
  Size get preferredSize => const Size.fromHeight(70);
}

class _DashboardHeaderState extends State<DashboardHeader>
    with SingleTickerProviderStateMixin {
  int? _hoveredIndex;
  late AnimationController _themeAnimController;

  @override
  void initState() {
    super.initState();
    _themeAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    _themeAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.whiteColor(context).withOpacity(0.8),
        border: Border(
          bottom: BorderSide(
            color: ColorManager.blackColor(context).withOpacity(0.05),
            width: 1,
          ),
        ),
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.isDesktop(context) ? 40 : 16,
                vertical: 12,
              ),
              child: Row(
                children: [
                  if (!Responsive.isDesktop(context))
                    _buildMenuButton(context)
                  else
                    _buildLogo(context),
                  const Spacer(),
                  if (Responsive.isDesktop(context)) _headerOptions(context),
                  const SizedBox(width: 16),
                  _themeToggleButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            gradient: ColorManager.primaryGradient(context),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.code_rounded,
            color: Colors.white,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'Portfolio',
          style: TextStyle(
            color: ColorManager.blackColor(context),
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuButton(BuildContext context) {
    return GestureDetector(
      onTap: widget.onMenuButtonPressed,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: ColorManager.blackColor(context).withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          Icons.menu_rounded,
          color: ColorManager.blackColor(context),
          size: 22,
        ),
      ),
    );
  }

  Widget _headerOptions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: MenuItems.menuItems.asMap().entries.map((item) {
        final isHovered = _hoveredIndex == item.key;
        return MouseRegion(
          onEnter: (_) => setState(() => _hoveredIndex = item.key),
          onExit: (_) => setState(() => _hoveredIndex = null),
          child: GestureDetector(
            onTap: () => widget.onOptionClick(item.key),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isHovered
                    ? ColorManager.accentPrimary.withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: isHovered ? 20 : 0,
                    child: isHovered
                        ? Icon(
                            item.value.icon,
                            size: 16,
                            color: ColorManager.accentPrimary,
                          )
                        : const SizedBox.shrink(),
                  ),
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 200),
                    style: TextStyle(
                      color: isHovered
                          ? ColorManager.accentPrimary
                          : ColorManager.blackColor(context),
                      fontWeight: isHovered ? FontWeight.w600 : FontWeight.w500,
                      fontSize: 14,
                      letterSpacing: 0.5,
                    ),
                    child: Text(item.value.title.toUpperCase()),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _themeToggleButton(BuildContext context) {
    final themeBloc = context.read<ThemeBloc>();
    final themeWatch = context.watch<ThemeBloc>();
    final isDark = themeWatch.state is! ThemeBlocStateLight;

    return GestureDetector(
      onTap: () {
        themeBloc.add(ThemeEventLight(isLightTheme: isDark));
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: isDark ? ColorManager.primaryGradient(context) : null,
          color: isDark
              ? null
              : ColorManager.blackColor(context).withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          boxShadow: isDark ? ColorManager.glowShadow(context) : null,
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return RotationTransition(
              turns: Tween(begin: 0.75, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
              ),
              child: ScaleTransition(scale: animation, child: child),
            );
          },
          child: Icon(
            isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
            key: ValueKey(isDark),
            color: isDark ? Colors.white : ColorManager.accentPrimary,
            size: 20,
          ),
        ),
      ),
    );
  }
}
