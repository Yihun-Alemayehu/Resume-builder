import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc({required bool isDarkMode})
      : super(ThemeState(themeData: isDarkMode ? ThemeData.dark() : ThemeData.light())) {
    on<ToggleThemeEvent>(_onToggleTheme);
  }

  void _onToggleTheme(ToggleThemeEvent event, Emitter<ThemeState> emit) async {
    final newTheme = state.themeData.brightness == Brightness.dark
        ? ThemeData.light()
        : ThemeData.dark();
    
    // Save theme preference
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', newTheme.brightness == Brightness.dark);
    
    emit(ThemeState(themeData: newTheme));
  }
}
