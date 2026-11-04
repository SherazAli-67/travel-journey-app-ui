import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travel_journey_app/constants/number_constant.dart';
import 'package:travel_journey_app/core/app_colors.dart';
import 'package:travel_journey_app/core/app_textstyles.dart';
import 'package:travel_journey_app/core/models/category_filter_model.dart';
import 'package:travel_journey_app/core/models/detail_tab_model.dart';

class CategoryChipRow extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final List<CategoryFilterModel>? categories;
  final List<DetailTabModel>? tabs;

  const CategoryChipRow({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
    this.categories,
    this.tabs,
  }) : assert(categories != null || tabs != null);

  @override
  Widget build(BuildContext context) {
    final itemCount = categories?.length ?? tabs!.length;
    return Row(
      spacing: NumberConstant.chipGap,
      children: List.generate(itemCount, (index) {
        final isSelected = selectedIndex == index;
        final label = categories?[index].label ?? tabs![index].label;
        final iconAsset = categories?[index].iconAsset;
        final activeStyle = categories != null ? AppTextStyles.chipLabelActive : AppTextStyles.detailTabActive;
        final inactiveStyle = categories != null ? AppTextStyles.chipLabel : AppTextStyles.detailTabInactive;
        return Expanded(
          child: GestureDetector(
            onTap: () => onSelected(index),
            child: Container(
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.chipInactive,
                borderRadius: .circular(isSelected ? NumberConstant.pillRadius : NumberConstant.cardRadius),
              ),
              padding: .symmetric(
                horizontal: NumberConstant.chipPaddingH,
                vertical: NumberConstant.chipPaddingV,
              ),
              child: Row(
                mainAxisAlignment: .center,
                spacing: NumberConstant.chipGap,
                children: [
                  if (iconAsset != null)
                    SvgPicture.asset(
                      iconAsset,
                      colorFilter: .mode(isSelected ? AppColors.onPrimary : AppColors.white, .srcIn),
                    ),
                  Flexible(
                    child: Text(
                      label,
                      style: isSelected ? activeStyle : inactiveStyle,
                      overflow: .ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
