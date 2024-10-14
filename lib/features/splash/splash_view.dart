import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_app/core/conf/page_route_name.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, PageRouteName.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/light_splash_background.png',
      fit: BoxFit.cover,
    );
  }
}
