import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel_journey_app/constants/string_const.dart';
import 'package:travel_journey_app/core/app_colors.dart';
import 'package:travel_journey_app/routing/router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: .light,
      statusBarBrightness: .dark,
      systemNavigationBarColor: AppColors.background,
      systemNavigationBarIconBrightness: .light,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: StringConst.appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: .dark,
        fontFamily: StringConst.appFontFamily,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: .dark(
          primary: AppColors.primary,
          onPrimary: AppColors.onPrimary,
          surface: AppColors.background,
          onSurface: AppColors.white,
        ),
        textTheme: ThemeData.dark().textTheme.apply(
          fontFamily: StringConst.appFontFamily,
          bodyColor: AppColors.white,
          displayColor: AppColors.white,
        ),
      ),
      routerConfig: router,
      builder: (ctx, child) => child!,
    );
  }
}
