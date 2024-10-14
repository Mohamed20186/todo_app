import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/conf/application_theme_manager.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(ApplicationThemeManager.lightThemeData);

  void changeTheme({required isDark}) {
    if (isDark) {
      emit(ApplicationThemeManager.darkThemeData);
    } else {
      emit(ApplicationThemeManager.lightThemeData);
    }
  }
}
