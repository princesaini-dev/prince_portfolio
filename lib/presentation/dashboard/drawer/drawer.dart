import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prince_portfolio/app/bloc_theme/theme_bloc.dart';
import 'package:prince_portfolio/app/bloc_theme/theme_bloc_event.dart';
import 'package:prince_portfolio/app/bloc_theme/thme_bloc_state.dart';
import 'package:prince_portfolio/presentation/dashboard/header/menu_items.dart';
import 'package:prince_portfolio/presentation/resources/color_manager.dart';
import 'package:prince_portfolio/presentation/resources/string_manager.dart';
import 'package:prince_portfolio/utils/extention_context.dart';

class DrawerWidget extends StatelessWidget {
  final Function(int index) onMenuButtonPressed;
  const DrawerWidget({required this.onMenuButtonPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: context.width * .6,
      backgroundColor: ColorManager.greyColor(context),
      elevation: 10,
      shadowColor: ColorManager.greyColor(context),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 100,
            ),
            Divider(
              color: ColorManager.blackColor(context).withOpacity(.4),
            ),
            _themeModeButton(context),
            Divider(
              color: ColorManager.blackColor(context).withOpacity(.4),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: MenuItems.menuItems
                    .asMap()
                    .entries
                    .map((item) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextButton.icon(
                            style: TextButton.styleFrom(
                                foregroundColor:
                                    ColorManager.blackColor(context)
                                        .withOpacity(.5)),
                            onPressed: () {
                              onMenuButtonPressed(item.key);
                            },
                            icon: Icon(item.value.icon,
                                size: 20,
                                color: ColorManager.blackColor(context)),
                            label: SizedBox(
                              width: context.width,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  item.value.title.toUpperCase(),
                                  style: TextStyle(
                                      color: ColorManager.blackColor(context),
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _themeModeButton(BuildContext context) {
    final themeBloc = context.read<ThemeBloc>();
    final themeWatch = context.watch<ThemeBloc>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.light_mode,
                  color: ColorManager.blackColor(context),
                ),
              ),
              Text(
                StringManager.darkMode,
                style: TextStyle(
                    color: ColorManager.blackColor(context),
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
          Transform.scale(
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
          )
        ],
      ),
    );
  }
}
