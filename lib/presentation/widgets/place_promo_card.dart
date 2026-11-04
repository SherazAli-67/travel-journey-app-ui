import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travel_journey_app/constants/motion_constant.dart';
import 'package:travel_journey_app/constants/number_constant.dart';
import 'package:travel_journey_app/core/app_colors.dart';
import 'package:travel_journey_app/core/app_textstyles.dart';
import 'package:travel_journey_app/core/asset_res.dart';
import 'package:travel_journey_app/core/models/place_model.dart';
import 'package:travel_journey_app/presentation/widgets/scale_on_tap.dart';

class PlacePromoCard extends StatelessWidget {
  final PlaceModel place;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;
  final bool isFavorite;
  final double? aspectRatio;
  final double parallaxOffset;
  final bool enableParallax;

  const PlacePromoCard({
    super.key,
    required this.place,
    this.onTap,
    this.onFavoriteTap,
    this.isFavorite = false,
    this.aspectRatio,
    this.parallaxOffset = 0,
    this.enableParallax = false,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final card = ScaleOnTap(
          onTap: onTap,
          child: ClipRRect(
            borderRadius: .circular(NumberConstant.cardRadius),
            child: Stack(
              fit: .expand,
              children: [
                _buildParallaxImage(constraints),
                Positioned(
                  left: NumberConstant.promoPaddingH,
                  right: NumberConstant.promoPaddingH,
                  bottom: NumberConstant.promoPaddingV,
                  child: ClipRRect(
                    borderRadius: .circular(NumberConstant.promoRadius),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.glassWhite5,
                          borderRadius: .circular(NumberConstant.promoRadius),
                        ),
                        padding: .symmetric(
                          horizontal: NumberConstant.promoPaddingH,
                          vertical: NumberConstant.promoPaddingV,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: .start,
                                spacing: 2,
                                children: [
                                  Text(
                                    place.name,
                                    style: AppTextStyles.placeName,
                                    maxLines: 1,
                                  ),
                                  Row(
                                    spacing: NumberConstant.promoMetaGap,
                                    children: [
                                      Flexible(
                                        child: Row(
                                          spacing: NumberConstant.promoInnerGap,
                                          children: [
                                            Text(
                                              place.formattedPrice,
                                              style: AppTextStyles.placePrice,
                                            ),
                                            Container(
                                              decoration: const BoxDecoration(
                                                color: AppColors.white,
                                                shape: .circle,
                                              ),
                                              padding: .all(2),
                                            ),
                                            Flexible(
                                              child: Row(
                                                spacing: 4,
                                                children: [
                                                  SvgPicture.asset(
                                                    AssetRes.icLocationMarker,
                                                    colorFilter: .mode(
                                                      AppColors.primary,
                                                      .srcIn,
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      place.location,
                                                      style: AppTextStyles.placeLocation,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: onFavoriteTap,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: AppColors.black10,
                                  shape: .circle,
                                ),
                                padding: .all(NumberConstant.heartButtonPadding),
                                child: TweenAnimationBuilder<double>(
                                  key: ValueKey(isFavorite),
                                  tween: Tween(begin: 0.75, end: 1),
                                  duration: MotionConstant.fast,
                                  curve: Curves.easeOutBack,
                                  builder: (context, scale, child) {
                                    return Transform.scale(
                                      scale: scale,
                                      child: child,
                                    );
                                  },
                                  child: SvgPicture.asset(
                                    isFavorite
                                        ? AssetRes.icFavoriteFilled
                                        : AssetRes.icFavoriteOutlined,
                                    colorFilter: .mode(
                                      isFavorite ? AppColors.primary : AppColors.white,
                                      .srcIn,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );

        if (aspectRatio != null) {
          return AspectRatio(
            aspectRatio: aspectRatio!,
            child: card,
          );
        }

        if (!constraints.maxHeight.isFinite) {
          return AspectRatio(
            aspectRatio: NumberConstant.placeCardAspectRatio,
            child: card,
          );
        }

        return card;
      },
    );
  }

  Widget _buildParallaxImage(BoxConstraints constraints) {
    final hasSize =
        constraints.maxWidth.isFinite && constraints.maxHeight.isFinite;
    final image = Image.asset(
      place.imageAsset,
      fit: .cover,
      width: hasSize ? constraints.maxWidth : null,
      height: hasSize ? constraints.maxHeight : null,
      alignment: enableParallax
          ? Alignment(
              (parallaxOffset / MotionConstant.carouselParallaxFactor)
                  .clamp(-1.0, 1.0),
              0,
            )
          : .center,
    );

    if (!enableParallax) return image;

    return ClipRect(
      child: Transform.translate(
        offset: Offset(parallaxOffset, 0),
        child: Transform.scale(
          scale: MotionConstant.carouselImageOverflowScale,
          child: image,
        ),
      ),
    );
  }
}
