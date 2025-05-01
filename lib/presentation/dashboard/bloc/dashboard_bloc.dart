import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prince_portfolio/domain/database_services.dart';
import 'package:prince_portfolio/domain/firebase_services.dart';
import 'package:prince_portfolio/presentation/dashboard/bloc/dashboard_bloc_events.dart';
import 'package:prince_portfolio/presentation/dashboard/bloc/dashboard_bloc_state.dart';
import 'package:prince_portfolio/supabase_client.dart';

class DashboardBloc extends Bloc<DashboardBlocEvents, DashboardBlocState> {
  final FirebaseService _firebaseService = FirebaseService();

  DashboardBloc() : super(DashboardLoadingBlocState()) {
    on<DashboardLoadingBlocEvents>(_actionLoadingEvent);
    on<DashboardFetchPortfolioDataEvents>(_actionFetchPortFolioEvent);
  }

  ///
  /// On fetching portfolio data.
  ///
  Future<void> _actionFetchPortFolioEvent(
      DashboardFetchPortfolioDataEvents event,
      Emitter<DashboardBlocState> emit) async {
    var result = await DatabaseServices().getPortfolioData();
    if (result != null) {
      emit(DashboardSuccessBlocState(portfolioDataModel: result));
    }
  }

  ///
  /// On dashboard loading event trigger.
  ///
  Future<void> _actionLoadingEvent(DashboardLoadingBlocEvents event,
      Emitter<DashboardBlocState> emit) async {
    emit(DashboardLoadingBlocState());
  }
}
