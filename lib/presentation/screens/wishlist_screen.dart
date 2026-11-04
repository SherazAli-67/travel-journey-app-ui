import 'package:flutter/material.dart';
import 'package:travel_journey_app/constants/string_const.dart';
import 'package:travel_journey_app/presentation/widgets/stub_tab_screen.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const StubTabScreen(title: StringConst.wishlistTitle);
  }
}
