import 'package:bloc/bloc.dart';
import 'package:faleh_hafez/presentation/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'theme_changer_event.dart';
part 'theme_changer_state.dart';

ThemeData mainTheme = lightTheme;

class ThemeChangerBloc extends Bloc<ThemeChangerEvent, ThemeChangerState> {
  ThemeChangerBloc() : super(ThemeChangerInitial()) {
    on<ChangeThemeEvent>((event, emit) {
      emit(ThemeChangerLoading());

      if (mainTheme == lightTheme) {
        mainTheme = darkTheme;
      } else {
        mainTheme = lightTheme;
      }

      emit(ThemeChangerLoaded(theme: mainTheme));
    });
  }
}
