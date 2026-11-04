import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travel_journey_app/constants/number_constant.dart';
import 'package:travel_journey_app/constants/string_const.dart';
import 'package:travel_journey_app/core/app_colors.dart';
import 'package:travel_journey_app/core/app_textstyles.dart';
import 'package:travel_journey_app/core/asset_res.dart';

class SearchBarRow extends StatelessWidget {
  final VoidCallback? onTap;
  final VoidCallback? onFilterTap;
  final String hint;

  const SearchBarRow({
    super.key,
    this.onTap,
    this.onFilterTap,
    this.hint = StringConst.searchHint,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: NumberConstant.chipGap,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.searchFill,
                borderRadius: .circular(NumberConstant.cardRadius),
              ),
              padding: .symmetric(
                horizontal: NumberConstant.searchFieldPaddingH,
                vertical: NumberConstant.chipPaddingV + 4,
              ),
              child: Row(
                spacing: NumberConstant.chipGap,
                children: [
                  //icSearch
                  SvgPicture.asset(AssetRes.icSearch),
                  Text(hint, style: AppTextStyles.searchPlaceholder,)
                  //hint, searchPlaceHolder
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: onFilterTap,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: .circular(NumberConstant.pillRadius),
              border: .all(color: AppColors.borderWhite8, width: 1.5),
            ),
            padding: .all(NumberConstant.filterButtonPadding),
            //icFilter
            child: SvgPicture.asset(AssetRes.icFilter)
          ),
        ),
      ],
    );
  }
}
