import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travel_journey_app/constants/number_constant.dart';
import 'package:travel_journey_app/core/app_colors.dart';

class CircleIconButton extends StatelessWidget {
  final String iconAsset;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color iconColor;
  final Color? borderColor;
  final double padding;
  final bool showBadge;
  final Color badgeColor;

  const CircleIconButton({
    super.key,
    required this.iconAsset,
    this.onTap,
    this.backgroundColor = AppColors.glassWhite8,
    this.iconColor = AppColors.white,
    this.borderColor,
    this.padding = NumberConstant.circleButtonPadding,
    this.showBadge = false,
    this.badgeColor = AppColors.notificationRed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          shape: .circle,
          border: borderColor == null ? null : .all(color: borderColor!, width: 1.5),
        ),
        alignment: .topCenter,
        padding: .all(padding),
        child: Stack(
          clipBehavior: .none,
          children: [
            SvgPicture.asset(iconAsset, colorFilter: .mode(iconColor, .srcIn),),
            if (showBadge)
              Positioned(
                right: 0,
                top: 0,
                child: ClipRRect(
                  borderRadius: .circular(NumberConstant.promoRadius),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.glassWhite5,
                        borderRadius: .circular(NumberConstant.promoRadius),
                      ),
                      padding: .symmetric(
                        horizontal: NumberConstant.promoPaddingH,
                        vertical: NumberConstant.promoPaddingV,
                      ),)))

              ),
          ],
        ),
      ),
    );
  }
}
