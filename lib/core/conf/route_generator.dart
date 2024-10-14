import 'package:flutter/material.dart';
import 'package:todo_app/core/conf/page_route_name.dart';
import 'package:todo_app/features/layout/layout_view.dart';
import 'package:todo_app/features/auth/pages/login/login_view.dart';
import 'package:todo_app/features/auth/pages/regestration/regestration_view.dart';
import 'package:todo_app/features/splash/splash_view.dart';

class RouteGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PageRouteName.initial:
        return MaterialPageRoute(
          builder: (context) => const SplashView(),
          settings: settings,
        );
      case PageRouteName.login:
        return MaterialPageRoute(
          builder: (context) => LoginView(),
          settings: settings,
        );
      case PageRouteName.regestration:
        return MaterialPageRoute(
          builder: (context) => const RegistrationView(),
          settings: settings,
        );
      case PageRouteName.layOut:
        return MaterialPageRoute(
          builder: (context) => const LayoutView(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const SplashView(),
          settings: settings,
        );
    }
  }
}
