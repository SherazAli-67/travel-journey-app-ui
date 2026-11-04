import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travel_journey_app/constants/number_constant.dart';
import 'package:travel_journey_app/core/app_colors.dart';
import 'package:travel_journey_app/core/app_textstyles.dart';
import 'package:travel_journey_app/core/asset_res.dart';
import 'package:travel_journey_app/core/models/place_model.dart';

class PlacePromoCard extends StatelessWidget {
  final PlaceModel place;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;
  final bool isFavorite;
  final double? aspectRatio;

  const PlacePromoCard({
    super.key,
    required this.place,
    this.onTap,
    this.onFavoriteTap,
    this.isFavorite = false,
    this.aspectRatio,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final card = GestureDetector(
          onTap: onTap,
          child: ClipRRect(
            borderRadius: .circular(NumberConstant.cardRadius),
            child: Stack(
              fit: .expand,
              children: [
                Image.asset(
                  place.imageAsset,
                  fit: .cover,
                  width: constraints.maxWidth.isFinite ? constraints.maxWidth : null,
                  height: constraints.maxHeight.isFinite ? constraints.maxHeight : null,
                ),
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
                                  //place.name, placeName, maxLines:1,
                                  Text(place.name, style: AppTextStyles.placeName, maxLines: 1,),
                                  Row(
                                    spacing: NumberConstant.promoMetaGap,
                                    children: [
                                      Flexible(
                                        child: Row(
                                          spacing: NumberConstant.promoInnerGap,
                                          children: [
                                            //place.formattedPrice, placePrice
                                            Text(place.formattedPrice, style: AppTextStyles.placePrice,),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: AppColors.white,
                                                shape: .circle,
                                              ),
                                              padding: .all(2),
                                            ),
                                            Flexible(
                                              child: Row(
                                                spacing: 4,
                                                children: [
                                                  //icLocationMarker, primaryColor
                                                  SvgPicture.asset(AssetRes.icLocationMarker, colorFilter: .mode(AppColors.primary, .srcIn),),

                                                  //place.location, placeLocation, maxLines:1
                                                  Flexible(
                                                    child:  Text(place.location, style: AppTextStyles.placeLocation,),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                     /* Row(
                                        spacing: 4,
                                        children: [
                                          SvgPicture.asset(AssetRes.icRatingStar, colorFilter: .mode(AppColors.primary, .srcIn),),
                                          Text(place.rating.toStringAsFixed(1), style: AppTextStyles.placeRating,)
                                        ],
                                      ),*/
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: onFavoriteTap,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.black10,
                                  shape: .circle,
                                ),
                                padding: .all(NumberConstant.heartButtonPadding),
                                child: SvgPicture.asset(
                                  isFavorite ? AssetRes.icFavoriteFilled : AssetRes.icFavoriteOutlined,
                                  colorFilter: .mode(isFavorite ? AppColors.primary : AppColors.white, .srcIn),
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
}
