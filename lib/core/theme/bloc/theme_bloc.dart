import 'package:bloc/bloc.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ToggleThemeEvent, ThemeState> {
  ThemeBloc() : super(LightThemeState()) {
    on<ToggleThemeEvent>((event, emit) {
      if (state is LightThemeState) {
        emit(DarkThemeState());
      } else {
        emit(LightThemeState());
      }
    });
  }
}
