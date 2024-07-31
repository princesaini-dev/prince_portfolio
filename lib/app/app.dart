import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prince_portfolio/app/bloc_theme/theme_bloc.dart';
import 'package:prince_portfolio/app/bloc_theme/thme_bloc_state.dart';
import 'package:prince_portfolio/presentation/resources/routes_manager.dart';

class MyApp extends StatefulWidget {
  const MyApp._internal(); // private named constructor
  final int appState = 0;
  static const MyApp instance =
      MyApp._internal(); // single instance -- singleton

  factory MyApp() => instance; // factory for the class instance

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
//  AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  void didChangeDependencies() {
    //  _appPreferences.getLocal().then((local) => {context.setLocale(local)});

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ThemeBloc(),
          )
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
        ));
  }
}
