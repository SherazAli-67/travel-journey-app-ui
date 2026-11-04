import 'package:flutter/material.dart';
import 'package:travel_journey_app/constants/string_const.dart';
import 'package:travel_journey_app/core/app_colors.dart';
import 'package:travel_journey_app/routing/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: StringConst.appTitle,
      theme: ThemeData(
        brightness: .dark,
        fontFamily: StringConst.appFontFamily,
        scaffoldBackgroundColor: AppColors.background,
      ),
      routerConfig: router,
      builder: (ctx, child) => child!,
    );
  }
}
