import 'package:flutter/material.dart';
import 'package:prince_portfolio/presentation/dashboard/components/about_me/about_me.dart';
import 'package:prince_portfolio/presentation/dashboard/components/contact/contact_me.dart';
import 'package:prince_portfolio/presentation/dashboard/components/resume/resume.dart';
import 'package:prince_portfolio/presentation/dashboard/drawer/drawer.dart';
import 'package:prince_portfolio/presentation/dashboard/header/dashboard_header.dart';
import 'package:prince_portfolio/presentation/dashboard/components/user_detail/user_detail.dart';
import 'package:prince_portfolio/presentation/resources/color_manager.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ItemScrollController _scrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: ColorManager.whiteColor(context),
          drawer: DrawerWidget(
            onMenuButtonPressed: (index) {
              _closeDrawer();
              _scrollToIndex(scrollToIndex: index);
            },
          ),
          appBar: DashboardHeader(
            onMenuButtonPressed: () {
              _openDrawer();
            },
            onOptionClick: (index) {
              _scrollToIndex(scrollToIndex: index);
            },
          ),
          body: ScrollablePositionedList.builder(
            itemScrollController: _scrollController,
            itemCount: dashboardWidgetList.length,
            itemBuilder: (context, index) {
              return dashboardWidgetList[index];
            },
          ),
        ),
      ),
    );
  }

  List<Widget> dashboardWidgetList = [
    const UserDetail(),
    AboutMe(),
    ContactMe(),
    const MyResume()
  ];

  void _scrollToIndex({required int scrollToIndex}) {
    _scrollController.scrollTo(
        index: scrollToIndex, duration: const Duration(seconds: 1));
  }

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void _closeDrawer() {
    _scaffoldKey.currentState?.closeDrawer();
  }
}
