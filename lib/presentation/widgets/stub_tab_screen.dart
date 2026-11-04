import 'package:flutter/material.dart';
import 'package:travel_journey_app/constants/number_constant.dart';
import 'package:travel_journey_app/constants/string_const.dart';
import 'package:travel_journey_app/core/app_textstyles.dart';
import 'package:travel_journey_app/core/asset_res.dart';

class StubTabScreen extends StatelessWidget {
  final String title;

  const StubTabScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: .expand,
      children: [
        Positioned.fill(
          child: Image.asset(AssetRes.bgOverlay, fit: .cover,),
        ),
        SafeArea(
          child: Padding(
            padding: .fromLTRB(
              NumberConstant.horizontalPadding,
              NumberConstant.sectionSpacing,
              NumberConstant.horizontalPadding,
              NumberConstant.bottomNavHeight + NumberConstant.bottomNavBottomInset,
            ),
            child: Center(
              child: Column(
                mainAxisSize: .min,
                spacing: NumberConstant.chipGap,
                children: [
                  Text(title, style: AppTextStyles.screenTitle, textAlign: .center,),
                  Text(StringConst.stubComingSoon, style: AppTextStyles.bodyMedium, textAlign: .center,),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
