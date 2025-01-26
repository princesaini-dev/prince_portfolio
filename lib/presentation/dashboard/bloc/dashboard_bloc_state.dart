abstract class DashboardBlocState {}

class DashboardLoadingBlocState extends DashboardBlocState {}

class DashboardSuccessBlocState extends DashboardBlocState {
  final dynamic portfolioDataModel;

  DashboardSuccessBlocState({required this.portfolioDataModel});
}

class DashboardErrorBlocState extends DashboardBlocState {}
