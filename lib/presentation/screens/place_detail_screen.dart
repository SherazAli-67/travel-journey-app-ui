import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:travel_journey_app/constants/number_constant.dart';
import 'package:travel_journey_app/constants/string_const.dart';
import 'package:travel_journey_app/core/app_colors.dart';
import 'package:travel_journey_app/core/app_data.dart';
import 'package:travel_journey_app/core/app_textstyles.dart';
import 'package:travel_journey_app/core/asset_res.dart';
import 'package:travel_journey_app/core/models/place_model.dart';
import 'package:travel_journey_app/presentation/providers/place_detail_provider.dart';
import 'package:travel_journey_app/presentation/widgets/category_chip_row.dart';
import 'package:travel_journey_app/presentation/widgets/circle_icon_button.dart';

class PlaceDetailScreen extends StatelessWidget {
  final String placeId;

  const PlaceDetailScreen({super.key, required this.placeId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PlaceDetailProvider(),
      child: _PlaceDetailView(place: AppData.placeById(placeId)),
    );
  }
}

class _PlaceDetailView extends StatelessWidget {
  final PlaceModel place;

  const _PlaceDetailView({required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: .expand,
        children: [
          Positioned.fill(
            child: Image.asset(AssetRes.bgOverlay, fit: .cover,),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              final heroHeight = constraints.maxHeight * NumberConstant.detailHeroHeightFraction;
              return Column(
                children: [
                  SizedBox(
                    height: heroHeight,
                    width: double.infinity,
                    child: _buildHero(context),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: .fromLTRB(
                        NumberConstant.horizontalPadding,
                        NumberConstant.homeContentSpacing,
                        NumberConstant.horizontalPadding,
                        NumberConstant.sectionSpacing,
                      ),
                      child: Column(
                        crossAxisAlignment: .start,
                        spacing: NumberConstant.homeContentSpacing,
                        children: [
                          _buildTitleRow(),
                          _buildInfoTiles(),
                          Consumer<PlaceDetailProvider>(
                            builder: (context, provider, _) => CategoryChipRow(
                              tabs: AppData.detailTabs,
                              selectedIndex: provider.selectedTabIndex,
                              onSelected: provider.selectTab,
                            ),
                          ),
                          _buildTabContent(context),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHero(BuildContext context) {
    final provider = context.watch<PlaceDetailProvider>();
    final gallery = place.galleryAssets;
    return Stack(
      fit: .expand,
      children: [
        ClipRRect(
          borderRadius: .vertical(bottom: Radius.circular(NumberConstant.heroBottomRadius)),
          child: PageView.builder(
            controller: provider.pageController,
            itemCount: gallery.length,
            onPageChanged: provider.setGalleryIndex,
            itemBuilder: (context, index) => Image.asset(gallery[index], fit: .cover,),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: .symmetric(
              horizontal: NumberConstant.horizontalPadding,
              vertical: NumberConstant.homeHeaderSpacing,
            ),
            child: Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                CircleIconButton(
                  iconAsset: AssetRes.icArrowBack,
                  onTap: () => context.pop(),
                ),
                CircleIconButton(
                  iconAsset: provider.isFavorite ? AssetRes.icFavoriteFilled : AssetRes.icFavoriteOutlined,
                  iconColor: AppColors.primary,
                  onTap: provider.toggleFavorite,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: NumberConstant.sectionSpacing,
          child: Row(
            mainAxisAlignment: .center,
            spacing: NumberConstant.chipGap,
            children: List.generate(gallery.length, (index) {
              final isActive = provider.galleryIndex == index;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: isActive ? AppColors.primary : AppColors.glassWhite30,
                  borderRadius: .circular(NumberConstant.pillRadius),
                ),
                padding: .symmetric(
                  horizontal: isActive ? NumberConstant.chipGap + 4 : 3,
                  vertical: 3,
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildTitleRow() {
    return Row(
      children: [
        Expanded(
          child: Text(place.name, style: AppTextStyles.detailTitle,),
        ),
        Row(
          spacing: 4,
          children: [
            SvgPicture.asset(AssetRes.icRatingStar, colorFilter: .mode(AppColors.primary, .srcIn),),
            Text(place.rating.toStringAsFixed(1), style: AppTextStyles.placeRating,),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoTiles() {
    final items = [
      (StringConst.locationLabel, place.location),
      (StringConst.openLabel, place.openHours),
      (StringConst.weatherLabel, place.weather),
    ];
    return Row(
      spacing: NumberConstant.chipGap,
      children: items
          .map(
            (item) => Expanded(
              child: ClipRRect(
                borderRadius: .circular(NumberConstant.infoTileRadius),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.glassWhite8,
                      borderRadius: .circular(NumberConstant.infoTileRadius),
                      border: .all(color: AppColors.borderWhite8, width: 1.5),
                    ),
                    padding: .symmetric(
                      horizontal: NumberConstant.chipPaddingH + 4,
                      vertical: NumberConstant.chipPaddingV + 5,
                    ),
                    child: Column(
                      crossAxisAlignment: .start,
                      spacing: 10,
                      children: [
                        Text(item.$1, style: AppTextStyles.infoLabel,),
                        Text(item.$2, style: AppTextStyles.infoValue,),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildTabContent(BuildContext context) {
    final tabIndex = context.watch<PlaceDetailProvider>().selectedTabIndex;
    if (tabIndex != 0) {
      return Text(StringConst.stubComingSoon, style: AppTextStyles.bodyMedium,);
    }
    return Column(
      crossAxisAlignment: .start,
      spacing: NumberConstant.chipGap,
      children: [
        Text(StringConst.overview, style: AppTextStyles.sectionTitle,),
        Text(place.overview, style: AppTextStyles.bodyMedium,),
      ],
    );
  }
}
