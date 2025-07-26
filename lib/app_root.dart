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
            theme: ThemeData(
              brightness: Brightness.light,
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
            ),
            themeMode: state is ThemeBlocStateLight
                ? ThemeMode.light
                : ThemeMode.dark,
            debugShowCheckedModeBanner: false,
            onGenerateRoute: RouteGenerator.getRoute,
            initialRoute: Routes.dashboardRoute,
          );
        },
      ),
    );
  }
}
