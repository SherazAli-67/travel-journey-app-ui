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

class PlacePromoCard extends StatefulWidget {
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
  State<PlacePromoCard> createState() => _PlacePromoCardState();
}

class _PlacePromoCardState extends State<PlacePromoCard>
    with TickerProviderStateMixin {
  late final AnimationController _favoriteController;
  late final AnimationController _burstController;
  late final Animation<double> _favoriteScale;
  late final Animation<double> _burstOpacity;
  late final Animation<double> _burstScale;

  @override
  void initState() {
    super.initState();
    _favoriteController = AnimationController(
      vsync: this,
      duration: MotionConstant.favoriteBounce,
    );
    _favoriteScale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1, end: 1.35), weight: 35),
      TweenSequenceItem(tween: Tween(begin: 1.35, end: 0.85), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 0.85, end: 1.15), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 1.15, end: 1), weight: 20),
    ]).animate(
      CurvedAnimation(parent: _favoriteController, curve: Curves.easeOut),
    );

    _burstController = AnimationController(
      vsync: this,
      duration: MotionConstant.doubleTapBurst,
    );
    _burstOpacity = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: 1), weight: 20),
      TweenSequenceItem(tween: ConstantTween(1), weight: 45),
      TweenSequenceItem(tween: Tween(begin: 1, end: 0), weight: 35),
    ]).animate(_burstController);
    _burstScale = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 0.2, end: 1.2).chain(
          CurveTween(curve: Curves.easeOutBack),
        ),
        weight: 45,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.2, end: 1.45).chain(
          CurveTween(curve: Curves.easeOut),
        ),
        weight: 55,
      ),
    ]).animate(_burstController);
  }

  @override
  void didUpdateWidget(covariant PlacePromoCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isFavorite != widget.isFavorite) {
      _playFavoriteBounce();
    }
  }

  @override
  void dispose() {
    _favoriteController.dispose();
    _burstController.dispose();
    super.dispose();
  }

  void _playFavoriteBounce() {
    if (!mounted) return;
    if (MediaQuery.disableAnimationsOf(context)) return;
    _favoriteController.forward(from: 0);
  }

  void _onFavoriteButtonTap() {
    widget.onFavoriteTap?.call();
  }

  void _onDoubleTap() {
    if (!widget.isFavorite) {
      widget.onFavoriteTap?.call();
    } else {
      _playFavoriteBounce();
    }
    if (MediaQuery.disableAnimationsOf(context)) return;
    _burstController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final card = ScaleOnTap(
          onTap: widget.onTap,
          onDoubleTap: _onDoubleTap,
          child: ClipRRect(
            borderRadius: .circular(NumberConstant.cardRadius),
            child: Stack(
              fit: .expand,
              children: [
                Hero(
                  tag: 'place-${widget.place.id}',
                  child: Material(
                    type: .transparency,
                    child: _buildParallaxImage(constraints),
                  ),
                ),
                _buildDoubleTapBurst(),
                _buildInfoOverlay(),
              ],
            ),
          ),
        );

        if (widget.aspectRatio != null) {
          return AspectRatio(
            aspectRatio: widget.aspectRatio!,
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

  Widget _buildDoubleTapBurst() {
    return IgnorePointer(
      child: Center(
        child: AnimatedBuilder(
          animation: _burstController,
          builder: (context, child) {
            if (_burstController.isDismissed) {
              return const SizedBox.shrink();
            }
            return Opacity(
              opacity: _burstOpacity.value.clamp(0.0, 1.0),
              child: Transform.scale(
                scale: _burstScale.value,
                child: child,
              ),
            );
          },
          child: SvgPicture.asset(
            AssetRes.icFavoriteFilled,
            width: MotionConstant.doubleTapHeartSize,
            height: MotionConstant.doubleTapHeartSize,
            colorFilter: .mode(AppColors.primary, .srcIn),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoOverlay() {
    return Positioned(
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
                        widget.place.name,
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
                                  widget.place.formattedPrice,
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
                                          widget.place.location,
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
                  onTap: _onFavoriteButtonTap,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.black10,
                      shape: .circle,
                    ),
                    padding: .all(NumberConstant.heartButtonPadding),
                    child: ScaleTransition(
                      scale: _favoriteScale,
                      child: SvgPicture.asset(
                        widget.isFavorite
                            ? AssetRes.icFavoriteFilled
                            : AssetRes.icFavoriteOutlined,
                        colorFilter: .mode(
                          widget.isFavorite ? AppColors.primary : AppColors.white,
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
    );
  }

  Widget _buildParallaxImage(BoxConstraints constraints) {
    final hasSize =
        constraints.maxWidth.isFinite && constraints.maxHeight.isFinite;
    final image = Image.asset(
      widget.place.imageAsset,
      fit: .cover,
      width: hasSize ? constraints.maxWidth : null,
      height: hasSize ? constraints.maxHeight : null,
      alignment: widget.enableParallax
          ? Alignment(
              (widget.parallaxOffset / MotionConstant.carouselParallaxFactor)
                  .clamp(-1.0, 1.0),
              0,
            )
          : .center,
    );

    if (!widget.enableParallax) return image;

    return ClipRect(
      child: Transform.translate(
        offset: Offset(widget.parallaxOffset, 0),
        child: Transform.scale(
          scale: MotionConstant.carouselImageOverflowScale,
          child: image,
        ),
      ),
    );
  }
}
