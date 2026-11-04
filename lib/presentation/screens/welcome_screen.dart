import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_journey_app/constants/number_constant.dart';
import 'package:travel_journey_app/constants/string_const.dart';
import 'package:travel_journey_app/core/app_colors.dart';
import 'package:travel_journey_app/core/app_textstyles.dart';
import 'package:travel_journey_app/core/asset_res.dart';
import 'package:travel_journey_app/routing/router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: .expand,
        children: [
          Positioned.fill(
            child: Image.asset(AssetRes.welcomeHero, fit: .cover,),
          ),
          SafeArea(
            child: Padding(
              padding: .symmetric(horizontal: NumberConstant.horizontalPadding),
              child: Column(
                children: [
                  Padding(
                    padding: .only(top: NumberConstant.sectionSpacing),
                    child: _buildLogo(),
                  ),
                  const Spacer(),
                  _buildCtaSection(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Row(
      mainAxisAlignment: .center,
      spacing: 7,
      children: [
        SvgPicture.asset(AssetRes.logoMark),
        SvgPicture.asset(AssetRes.logoText),
      ],
    );
  }

  Widget _buildCtaSection(BuildContext context) {
    return Stack(
      alignment: .bottomCenter,
      children: [
        Padding(
          padding: .only(bottom: NumberConstant.welcomeCtaButtonOverlap),
          child: ClipRRect(
            borderRadius: .circular(NumberConstant.cardRadius),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.glassWhite5,
                  borderRadius: .circular(NumberConstant.cardRadius),
                ),
                padding: .fromLTRB(
                  NumberConstant.sectionSpacing,
                  NumberConstant.sectionSpacing + 12,
                  NumberConstant.sectionSpacing,
                  NumberConstant.welcomeCtaButtonOverlap + NumberConstant.sectionSpacing,
                ),
                child: Column(
                  spacing: NumberConstant.chipPaddingH + 4,
                  children: [
                    Text(
                      '${StringConst.welcomeHeadlineLine1}\n${StringConst.welcomeHeadlineLine2}',
                      style: AppTextStyles.welcomeHeadline,
                      textAlign: .center,
                    ),
                    Text(StringConst.welcomeSubtitle, style: AppTextStyles.welcomeSubtitle, textAlign: .center,),
                  ],
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => context.go(NamedRoutes.home.routeName),
          child: SvgPicture.asset(AssetRes.welcomeCtaButton),
        ),
      ],
    );
  }
}
