import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:travel_journey_app/constants/motion_constant.dart';
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
import 'package:travel_journey_app/presentation/widgets/fade_slide_in.dart';

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

  static String heroTag(String placeId) => 'place-$placeId';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: .expand,
        children: [
          Positioned.fill(
            child: Image.asset(AssetRes.bgOverlay, fit: .cover),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              final heroHeight =
                  constraints.maxHeight * NumberConstant.detailHeroHeightFraction;
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
                          FadeSlideIn(child: _buildTitleRow()),
                          _buildInfoTiles(),
                          FadeSlideIn(
                            delay: MotionConstant.staggerStep * 4,
                            child: Consumer<PlaceDetailProvider>(
                              builder: (context, provider, _) => CategoryChipRow(
                                tabs: AppData.detailTabs,
                                selectedIndex: provider.selectedTabIndex,
                                onSelected: provider.selectTab,
                              ),
                            ),
                          ),
                          FadeSlideIn(
                            delay: MotionConstant.staggerStep * 5,
                            child: _buildTabContent(context),
                          ),
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
          borderRadius: .vertical(
            bottom: Radius.circular(NumberConstant.heroBottomRadius),
          ),
          child: PageView.builder(
            controller: provider.pageController,
            itemCount: gallery.length,
            onPageChanged: provider.setGalleryIndex,
            itemBuilder: (context, index) {
              final image = Image.asset(gallery[index], fit: .cover);
              if (index != 0) return image;
              return Hero(
                tag: heroTag(place.id),
                child: Material(
                  type: .transparency,
                  child: image,
                ),
              );
            },
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
                _FavoriteIconButton(
                  isFavorite: provider.isFavorite,
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
                duration: MotionConstant.normal,
                curve: MotionConstant.selectCurve,
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
          child: Text(place.name, style: AppTextStyles.detailTitle),
        ),
        Row(
          spacing: 4,
          children: [
            SvgPicture.asset(
              AssetRes.icRatingStar,
              colorFilter: .mode(AppColors.primary, .srcIn),
            ),
            Text(
              place.rating.toStringAsFixed(1),
              style: AppTextStyles.placeRating,
            ),
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
      children: [
        for (var i = 0; i < items.length; i++)
          Expanded(
            child: FadeSlideIn(
              delay: MotionConstant.staggerStep * (i + 1),
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
                        Text(items[i].$1, style: AppTextStyles.infoLabel),
                        Text(items[i].$2, style: AppTextStyles.infoValue),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildTabContent(BuildContext context) {
    final tabIndex = context.watch<PlaceDetailProvider>().selectedTabIndex;
    return AnimatedSwitcher(
      duration: MotionConstant.normal,
      switchInCurve: MotionConstant.enterCurve,
      switchOutCurve: MotionConstant.selectCurve,
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.04),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: KeyedSubtree(
        key: ValueKey(tabIndex),
        child: tabIndex != 0
            ? Text(
                StringConst.stubComingSoon,
                style: AppTextStyles.bodyMedium,
              )
            : Column(
                crossAxisAlignment: .start,
                spacing: NumberConstant.chipGap,
                children: [
                  Text(StringConst.overview, style: AppTextStyles.sectionTitle),
                  Text(place.overview, style: AppTextStyles.bodyMedium),
                ],
              ),
      ),
    );
  }
}

class _FavoriteIconButton extends StatefulWidget {
  final bool isFavorite;
  final VoidCallback onTap;

  const _FavoriteIconButton({
    required this.isFavorite,
    required this.onTap,
  });

  @override
  State<_FavoriteIconButton> createState() => _FavoriteIconButtonState();
}

class _FavoriteIconButtonState extends State<_FavoriteIconButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: MotionConstant.favoriteBounce,
    );
    _scale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1, end: 1.35), weight: 35),
      TweenSequenceItem(tween: Tween(begin: 1.35, end: 0.85), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 0.85, end: 1.15), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 1.15, end: 1), weight: 20),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void didUpdateWidget(covariant _FavoriteIconButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isFavorite != widget.isFavorite) {
      if (!MediaQuery.disableAnimationsOf(context)) {
        _controller.forward(from: 0);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: CircleIconButton(
        iconAsset: widget.isFavorite
            ? AssetRes.icFavoriteFilled
            : AssetRes.icFavoriteOutlined,
        iconColor: AppColors.primary,
        onTap: widget.onTap,
      ),
    );
  }
}
