import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prince_portfolio/data/portfolio_data_model.dart';
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

class _DashboardScreenState extends State<DashboardScreen>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ItemScrollController _scrollController = ItemScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    // Delay data fetching to improve FCP
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) {
          context.read<DashboardBloc>().add(DashboardFetchPortfolioDataEvents());
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: ColorManager.whiteColor(context),
        extendBodyBehindAppBar: true,
        drawer: DrawerWidget(
          onMenuButtonPressed: _scrollToIndex,
        ),
        body: Stack(
          children: [
            BlocBuilder<DashboardBloc, DashboardBlocState>(
              builder: (context, state) {
                if (state is DashboardLoadingBlocState) {
                  return _loadingIndicatorView(context);
                } else if (state is DashboardSuccessBlocState) {
                  final widgets =
                      _dashboardWidgetList(state.portfolioDataModel);
                  return ScrollablePositionedList.builder(
                    itemScrollController: _scrollController,
                    itemCount: widgets.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => widgets[index],
                  );
                } else {
                  return _errorView(context);
                }
              },
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: DashboardHeader(
                onMenuButtonPressed: _openDrawer,
                onOptionClick: _scrollToIndex,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loadingIndicatorView(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: ColorManager.backgroundGradient(context),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: ColorManager.cardColor(context),
                borderRadius: BorderRadius.circular(20),
                boxShadow: ColorManager.cardShadow(context),
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        ColorManager.accentPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Loading Portfolio...',
                    style: TextStyle(
                      color: ColorManager.blackColor(context).withOpacity(0.7),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _errorView(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: ColorManager.backgroundGradient(context),
      ),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(32),
          margin: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: ColorManager.cardColor(context),
            borderRadius: BorderRadius.circular(24),
            boxShadow: ColorManager.cardShadow(context),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.error_outline_rounded,
                  color: Colors.red,
                  size: 48,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Oops! Something went wrong',
                style: TextStyle(
                  color: ColorManager.blackColor(context),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Please check your connection and try again',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ColorManager.blackColor(context).withOpacity(0.6),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () {
                  context
                      .read<DashboardBloc>()
                      .add(DashboardFetchPortfolioDataEvents());
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  decoration: BoxDecoration(
                    gradient: ColorManager.primaryGradient(context),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Retry',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _dashboardWidgetList(PortfolioDataModel portfolioDataModel) {
    return [
      UserDetail(portfolioDataModel: portfolioDataModel),
      AboutMe(portfolioDataModel: portfolioDataModel),
      Projects(portfolioDataModel: portfolioDataModel),
      MyResume(resumeURL: portfolioDataModel.resumesURL ?? ''),
      const ContactMe(),
      _buildFooter(context),
    ];
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      decoration: BoxDecoration(
        color: ColorManager.cardColor(context),
        border: Border(
          top: BorderSide(
            color: ColorManager.blackColor(context).withOpacity(0.05),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: ColorManager.primaryGradient(context),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.code_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Prince Portfolio',
                style: TextStyle(
                  color: ColorManager.blackColor(context),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Built with Flutter & ❤️',
            style: TextStyle(
              color: ColorManager.blackColor(context).withOpacity(0.6),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '© 2024 All Rights Reserved',
            style: TextStyle(
              color: ColorManager.blackColor(context).withOpacity(0.4),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  void _scrollToIndex(int index) {
    if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
      Navigator.of(context).pop();
    }
    _scrollController.scrollTo(
      index: index,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutCubic,
    );
  }

  void _openDrawer() => _scaffoldKey.currentState?.openDrawer();
}
