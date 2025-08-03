import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prince_portfolio/presentation/dashboard/bloc/dashboard_bloc.dart';
import 'package:prince_portfolio/presentation/resources/routes_manager.dart';

import 'app/bloc_theme/theme_bloc.dart';
import 'app/bloc_theme/thme_bloc_state.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeBloc()),
        BlocProvider(create: (context) => DashboardBloc()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeBlocState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Prince Saini - Portfolio',
            theme: _buildLightTheme(),
            darkTheme: _buildDarkTheme(),
            themeMode: state is ThemeBlocStateLight
                ? ThemeMode.light
                : ThemeMode.dark,
            debugShowCheckedModeBanner: false,
            onGenerateRoute: RouteGenerator.getRoute,
            initialRoute: Routes.dashboardRoute,
            // Performance optimizations
            builder: (context, child) {
              return ScrollConfiguration(
                behavior: const MaterialScrollBehavior().copyWith(
                  dragDevices: {
                    PointerDeviceKind.mouse,
                    PointerDeviceKind.touch,
                    PointerDeviceKind.stylus,
                    PointerDeviceKind.unknown,
                  },
                  scrollbars: false,
                ),
                child: child!,
              );
            },
          );
        },
      ),
    );
  }

  ThemeData _buildLightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
        },
      ),
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
        },
      ),
    );
  }
}
