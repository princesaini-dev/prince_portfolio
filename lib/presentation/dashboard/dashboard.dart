import 'package:flutter/material.dart';
import 'package:prince_portfolio/presentation/dashboard/drawer/drawer.dart';
import 'package:prince_portfolio/presentation/dashboard/header/dashboard_header.dart';
import 'package:prince_portfolio/presentation/dashboard/user_detail/user_detail.dart';
import 'package:prince_portfolio/presentation/resources/color_manager.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: ColorManager.whiteColor(context),
          drawer: const DrawerWidget(),
          appBar: DashboardHeader(
            onMenuButtonPressed: () {
              _openDrawer();
            },
          ),
          body: const SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [UserDetail(), UserDetail()],
            ),
          ),
        ),
      ),
    );
  }

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }
}
