import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(LightThemeState()) {
    on<ToggleThemeEvent>((event, emit) {
      if (state is LightThemeState) {
        emit(DarkThemeState());
      } else {
        emit(LightThemeState());
      }
    });

    on<SystemThemeChangedEvent>((event, emit) {
      if (event.brightness == Brightness.dark) {
        emit(DarkThemeState());
      } else {
        emit(LightThemeState());
      }
    });
  }
}
