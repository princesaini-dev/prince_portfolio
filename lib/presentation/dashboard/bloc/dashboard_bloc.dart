import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prince_portfolio/data/static_portfolio_data.dart';
import 'package:prince_portfolio/presentation/dashboard/bloc/dashboard_bloc_events.dart';
import 'package:prince_portfolio/presentation/dashboard/bloc/dashboard_bloc_state.dart';

class DashboardBloc extends Bloc<DashboardBlocEvents, DashboardBlocState> {
  DashboardBloc() : super(DashboardLoadingBlocState()) {
    on<DashboardLoadingBlocEvents>(_actionLoadingEvent);
    on<DashboardFetchPortfolioDataEvents>(_actionFetchPortFolioEvent);
  }

  Future<void> _actionFetchPortFolioEvent(
      DashboardFetchPortfolioDataEvents event,
      Emitter<DashboardBlocState> emit) async {
    // Using static data instead of Supabase
    final portfolioData = StaticPortfolioData.getPortfolioData();
    emit(DashboardSuccessBlocState(portfolioDataModel: portfolioData));
  }

  Future<void> _actionLoadingEvent(DashboardLoadingBlocEvents event,
      Emitter<DashboardBlocState> emit) async {
    emit(DashboardLoadingBlocState());
  }
}
