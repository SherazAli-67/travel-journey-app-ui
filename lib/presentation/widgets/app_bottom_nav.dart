import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travel_journey_app/constants/number_constant.dart';
import 'package:travel_journey_app/core/app_colors.dart';
import 'package:travel_journey_app/core/asset_res.dart';

class AppBottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const AppBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });

  static const _items = [
    AssetRes.icHome,
    AssetRes.icCalendar,
    AssetRes.icMic,
    AssetRes.icWishlist,
    AssetRes.icSettings,
  ];

  static const micIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.black05,
        borderRadius: .circular(NumberConstant.pillRadius),
      ),
      // padding: .symmetric(horizontal: NumberConstant.bottomNavBarPaddingH),
      child: ClipRRect(

        borderRadius: .circular(NumberConstant.bottomNavRadius),
        child: BackdropFilter(

          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.glassWhite5,
              borderRadius: .circular(NumberConstant.promoRadius),
            ),
            padding: .symmetric(
              horizontal: NumberConstant.promoPaddingH,
              vertical: NumberConstant.bottomNavPaddingV,
            ),
            child: Row(
              mainAxisAlignment: .spaceBetween,
              children: List.generate(_items.length, (index) {
                final isMic = index == micIndex;
                final isSelected = selectedIndex == index;
                final iconColor = isMic
                    ? AppColors.onPrimary
                    : isSelected
                        ? AppColors.primary
                        : AppColors.white;
                return GestureDetector(
                  onTap: () => onSelected(index),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isMic ? AppColors.primary : Colors.transparent,
                      borderRadius: .circular(NumberConstant.pillRadius),
                    ),
                    padding: .symmetric(
                      horizontal: NumberConstant.bottomNavItemPaddingH,
                      vertical: isMic ? NumberConstant.circleButtonPadding : NumberConstant.bottomNavItemPaddingV,
                    ),
                    child: SvgPicture.asset(_items[index], colorFilter: .mode(iconColor, .srcIn),),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
