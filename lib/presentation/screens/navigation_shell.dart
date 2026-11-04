import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_journey_app/constants/number_constant.dart';
import 'package:travel_journey_app/presentation/widgets/app_bottom_nav.dart';

class NavigationShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const NavigationShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: .expand,
        children: [
          navigationShell,
          Positioned(
            left: NumberConstant.bottomNavHorizontalInset,
            right: NumberConstant.bottomNavHorizontalInset,
            bottom: NumberConstant.bottomNavBottomInset,
            child: SafeArea(
              top: false,
              child: AppBottomNav(
                selectedIndex: navigationShell.currentIndex,
                onSelected: (index) => navigationShell.goBranch(
                  index,
                  initialLocation: index == navigationShell.currentIndex,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
