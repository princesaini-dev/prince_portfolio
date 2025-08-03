import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prince_portfolio/data/portfolio_data_model.dart';
import 'package:prince_portfolio/presentation/base/custom_text_widget.dart';
import 'package:prince_portfolio/presentation/base/skeleton_loader.dart';
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
    super.build(context);

    return Scaffold(
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
            // Show skeleton instead of spinner for better perceived performance
            return const PortfolioSkeleton();
          } else if (state is DashboardSuccessBlocState) {
            return _buildDashboardContent(state.portfolioDataModel);
          } else {
            return _buildErrorView();
          }
        },
      ),
    );
  }

  /// **Optimized Dashboard Content - Prevent Layout Shifts**
  Widget _buildDashboardContent(PortfolioDataModel portfolioDataModel) {
    final widgets = _dashboardWidgetList(portfolioDataModel);

    return ScrollablePositionedList.builder(
      itemScrollController: _scrollController,
      itemCount: widgets.length,
      physics: const ClampingScrollPhysics(), // Better web performance
      itemBuilder: (context, index) {
        // Wrap each section in RepaintBoundary to prevent unnecessary repaints
        return RepaintBoundary(
          key: Key('section_$index'),
          child: widgets[index],
        );
      },
    );
  }

  /// **Error View with Retry**
  Widget _buildErrorView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          const CustomTextWidget(text: 'Something went wrong'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<DashboardBloc>().add(DashboardFetchPortfolioDataEvents());
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  /// **Dashboard Widget List**
  List<Widget> _dashboardWidgetList(PortfolioDataModel portfolioDataModel) {
    return [
      UserDetail(portfolioDataModel: portfolioDataModel),
      AboutMe(portfolioDataModel: portfolioDataModel),
      Projects(portfolioDataModel: portfolioDataModel),
      MyResume(
        resumeURL: portfolioDataModel.resumesURL ?? '',
      ),
       ContactMe(),
    ];
  }

  /// **Optimized Scroll to Section**
  void _scrollToIndex(int index) {
    if (index >= 0 && index < 5) {
      _scrollController.scrollTo(
        index: index,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
      );
    }
  }

  /// **Open Drawer**
  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }
}
