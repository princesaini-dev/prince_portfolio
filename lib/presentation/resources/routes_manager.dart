import 'package:flutter/material.dart';
import 'package:prince_portfolio/presentation/dashboard/dashboard.dart';

class Routes {
  static const String dashboardRoute = "/dashboard";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.dashboardRoute:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(''),
              ),
              body: const Center(child: Text('')),
            ));
  }
}
