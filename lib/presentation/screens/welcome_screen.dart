import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_journey_app/constants/motion_constant.dart';
import 'package:travel_journey_app/constants/number_constant.dart';
import 'package:travel_journey_app/constants/string_const.dart';
import 'package:travel_journey_app/core/app_colors.dart';
import 'package:travel_journey_app/core/app_textstyles.dart';
import 'package:travel_journey_app/core/asset_res.dart';
import 'package:travel_journey_app/presentation/widgets/scale_on_tap.dart';
import 'package:travel_journey_app/routing/router.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  static const _entranceDuration = Duration(milliseconds: 900);

  late final AnimationController _controller;
  late final Animation<double> _heroOpacity;
  late final Animation<double> _logoOpacity;
  late final Animation<Offset> _logoOffset;
  late final Animation<double> _ctaOpacity;
  late final Animation<Offset> _ctaOffset;
  late final Animation<double> _buttonOpacity;
  late final Animation<double> _buttonScale;
  var _started = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _entranceDuration);

    _heroOpacity = Tween<double>(begin: 0.85, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.45, curve: MotionConstant.enterCurve),
      ),
    );

    _logoOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0, 0.4, curve: MotionConstant.enterCurve),
    );
    _logoOffset = Tween<Offset>(
      begin: const Offset(0, -MotionConstant.slideDistance),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.4, curve: MotionConstant.enterCurve),
      ),
    );

    _ctaOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.2, 0.7, curve: MotionConstant.enterCurve),
    );
    _ctaOffset = Tween<Offset>(
      begin: const Offset(0, MotionConstant.slideDistance),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.7, curve: MotionConstant.enterCurve),
      ),
    );

    _buttonOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.45, 1, curve: MotionConstant.enterCurve),
    );
    _buttonScale = Tween<double>(begin: 0.88, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.45, 1, curve: MotionConstant.enterCurve),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.value = 1;
    } else {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Stack(
            fit: .expand,
            children: [
              Positioned.fill(
                child: Opacity(
                  opacity: _heroOpacity.value,
                  child: Image.asset(AssetRes.welcomeHero, fit: .cover),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: .symmetric(horizontal: NumberConstant.horizontalPadding),
                  child: Column(
                    children: [
                      Padding(
                        padding: .only(top: NumberConstant.sectionSpacing),
                        child: Opacity(
                          opacity: _logoOpacity.value,
                          child: Transform.translate(
                            offset: _logoOffset.value,
                            child: _buildLogo(),
                          ),
                        ),
                      ),
                      const Spacer(),
                      _buildCtaSection(context),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
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
        Opacity(
          opacity: _ctaOpacity.value,
          child: Transform.translate(
            offset: _ctaOffset.value,
            child: Padding(
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
                        Text(
                          StringConst.welcomeSubtitle,
                          style: AppTextStyles.welcomeSubtitle,
                          textAlign: .center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Opacity(
          opacity: _buttonOpacity.value,
          child: Transform.scale(
            scale: _buttonScale.value,
            child: ScaleOnTap(
              onTap: () => context.go(NamedRoutes.home.routeName),
              child: SvgPicture.asset(AssetRes.welcomeCtaButton),
            ),
          ),
        ),
      ],
    );
  }
}
