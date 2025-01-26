import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prince_portfolio/app/bloc_theme/theme_bloc.dart';
import 'package:prince_portfolio/app/bloc_theme/thme_bloc_state.dart';
import 'package:prince_portfolio/data/portfolio_data_model.dart';
import 'package:prince_portfolio/presentation/base/custom_text_widget.dart';
import 'package:prince_portfolio/presentation/dashboard/bloc/dashboard_bloc_events.dart';
import 'package:prince_portfolio/presentation/dashboard/bloc/dashboard_bloc_state.dart';
import 'package:prince_portfolio/presentation/dashboard/components/about_me/about_me.dart';
import 'package:prince_portfolio/presentation/dashboard/components/contact/contact_me.dart';
import 'package:prince_portfolio/presentation/dashboard/components/projects/projects.dart';
import 'package:prince_portfolio/presentation/dashboard/components/resume/resume.dart';
import 'package:prince_portfolio/presentation/dashboard/drawer/drawer.dart';
import 'package:prince_portfolio/presentation/dashboard/header/dashboard_header.dart';
import 'package:prince_portfolio/presentation/dashboard/components/user_detail/user_detail.dart';
import 'package:prince_portfolio/presentation/resources/color_manager.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'bloc/dashboard_bloc.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ItemScrollController _scrollController = ItemScrollController();

  @override
  void initState() {
    super.initState();
    context.read<DashboardBloc>().add(DashboardFetchPortfolioDataEvents());
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: ColorManager.whiteColor(context),
          drawer: DrawerWidget(
            onMenuButtonPressed: _scrollToIndex,
          ),
          appBar: DashboardHeader(
            onMenuButtonPressed: _openDrawer,
            onOptionClick: _scrollToIndex,
          ),
          body: BlocBuilder<DashboardBloc, DashboardBlocState>(
            builder: (context, state) {
              if (state is DashboardLoadingBlocState) {
                return _loadingIndicatorView(context);
              } else if (state is DashboardSuccessBlocState) {
                final widgets = _dashboardWidgetList(state.portfolioDataModel);
                return ScrollablePositionedList.builder(
                  itemScrollController: _scrollController,
                  itemCount: widgets.length,
                  itemBuilder: (context, index) => widgets[index],
                );
              } else {
                return const Center(child: CustomTextWidget(text: 'Error'));
              }
            },
          ),
        ),
      ),
    );
  }

  /// **Loading Indicator**
  Center _loadingIndicatorView(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: context.watch<ThemeBloc>().state is ThemeBlocStateLight
            ? Colors.black
            : Colors.white,
      ),
    );
  }

  /// **Dashboard Widget List**
  List<Widget> _dashboardWidgetList(PortfolioDataModel portfolioDataModel) {
    return [
      UserDetail(portfolioDataModel: portfolioDataModel),
      AboutMe(),
      const Projects(),
      ContactMe(),
      const MyResume(),
    ];
  }

  /// **Scroll to Section**
  void _scrollToIndex(int index) {
    _scrollController.scrollTo(
      index: index,
      duration: const Duration(seconds: 1),
    );
  }

  /// **Open Drawer**
  void _openDrawer() => _scaffoldKey.currentState?.openDrawer();
}
