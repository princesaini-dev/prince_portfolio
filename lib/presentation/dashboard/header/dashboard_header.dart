import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prince_portfolio/app/bloc_theme/theme_bloc.dart';
import 'package:prince_portfolio/app/bloc_theme/theme_bloc_event.dart';
import 'package:prince_portfolio/app/bloc_theme/thme_bloc_state.dart';

class DashboardHeader extends StatelessWidget implements PreferredSizeWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const SizedBox.shrink(),
      title: const Text('Dashboard'),
      actions: [_themeToggleButton(context)],
    );
  }

  Widget _themeToggleButton(BuildContext context) {
    final themeBloc = context.read<ThemeBloc>();
    final themeWatch = context.watch<ThemeBloc>();
    return Switch(
      activeColor: Colors.white,
      inactiveThumbColor: Colors.black,
      value: themeWatch.state is! ThemeBlocStateLight,
      onChanged: (value) {
        themeBloc.add(ThemeEventLight(
            isLightTheme: themeBloc.state is! ThemeBlocStateLight));
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
