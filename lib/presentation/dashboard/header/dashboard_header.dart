import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prince_portfolio/app/bloc_theme/theme_bloc.dart';
import 'package:prince_portfolio/app/bloc_theme/theme_bloc_event.dart';
import 'package:prince_portfolio/app/bloc_theme/thme_bloc_state.dart';
import 'package:prince_portfolio/presentation/dashboard/header/menu_items.dart';
import 'package:prince_portfolio/presentation/resources/color_manager.dart';
import 'package:prince_portfolio/utils/responsive.dart';

class DashboardHeader extends StatelessWidget implements PreferredSizeWidget {
  final Function() onMenuButtonPressed;
  final Function(int index) onOptionClick;
  const DashboardHeader(
      {required this.onMenuButtonPressed,
      required this.onOptionClick,
      super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorManager.whiteColor(context),
      leading: Responsive.isDesktop(context)
          ? const SizedBox.shrink()
          : IconButton(
              onPressed: onMenuButtonPressed,
              icon: Icon(
                Icons.menu,
                color: ColorManager.blackColor(context),
              )),
      title: Responsive.isDesktop(context)
          ? _headerOptions(context)
          : const SizedBox.shrink(),
      actions: [_themeToggleButton(context)],
    );
  }

  Widget _headerOptions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: MenuItems.menuItems
          .asMap()
          .entries
          .map((item) => TextButton(
              onPressed: () {
                onOptionClick(item.key);
              },
              style: TextButton.styleFrom(
                  foregroundColor:
                      ColorManager.blackColor(context).withOpacity(.5)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Text(
                  item.value.title.toUpperCase(),
                  style: TextStyle(
                      color: ColorManager.blackColor(context),
                      fontWeight: FontWeight.w500),
                ),
              )))
          .toList(),
    );
  }

  Widget _themeToggleButton(BuildContext context) {
    final themeBloc = context.read<ThemeBloc>();
    final themeWatch = context.watch<ThemeBloc>();
    return Transform.scale(
      scale: .8,
      child: Switch(
        activeColor: Colors.white,
        activeTrackColor: Colors.white.withOpacity(.2),
        inactiveThumbColor: Colors.black,
        inactiveTrackColor: Colors.white,
        value: themeWatch.state is! ThemeBlocStateLight,
        onChanged: (value) {
          themeBloc.add(ThemeEventLight(
              isLightTheme: themeBloc.state is! ThemeBlocStateLight));
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
