import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prince_portfolio/app/bloc_theme/theme_bloc_event.dart';
import 'package:prince_portfolio/app/bloc_theme/thme_bloc_state.dart';

class ThemeBloc extends Bloc<ThemeBlocEvent, ThemeBlocState> {
  ThemeBloc() : super(ThemeBlocStateLight()) {
    on<ThemeEventLight>(_actionToggleTheme);
  }

  FutureOr<void> _actionToggleTheme(
      ThemeEventLight event, Emitter<ThemeBlocState> emit) {
    emit(event.isLightTheme ? ThemeBlocStateLight() : ThemeBlocStateDark());
  }
}
