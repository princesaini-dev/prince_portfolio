import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prince_portfolio/app/bloc_theme/theme_bloc.dart';
import 'package:prince_portfolio/app/bloc_theme/theme_bloc_event.dart';
import 'package:prince_portfolio/app/bloc_theme/thme_bloc_state.dart';
import 'package:prince_portfolio/presentation/resources/color_manager.dart';
import 'package:prince_portfolio/presentation/resources/string_manager.dart';

class DashboardHeader extends StatelessWidget implements PreferredSizeWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const SizedBox.shrink(),
      title: _headerOptions(context),
      actions: [_themeToggleButton(context)],
    );
  }

  Widget _headerOptions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: _getOptionsList()
          .map((e) => TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                  foregroundColor:
                      ColorManager.blackColor(context).withOpacity(.5)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Text(
                  e.toUpperCase(),
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

  List<String> _getOptionsList() {
    List<String> list = [];
    list.add(StringManager.home);
    list.add(StringManager.about);
    list.add(StringManager.services);
    list.add(StringManager.projects);
    list.add(StringManager.contact);
    list.add(StringManager.blog);
    list.add(StringManager.resume);
    return list;
  }
}
