import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:travel_journey_app/constants/motion_constant.dart';
import 'package:travel_journey_app/constants/number_constant.dart';
import 'package:travel_journey_app/constants/string_const.dart';
import 'package:travel_journey_app/core/app_colors.dart';
import 'package:travel_journey_app/core/app_data.dart';
import 'package:travel_journey_app/core/app_textstyles.dart';
import 'package:travel_journey_app/core/asset_res.dart';
import 'package:travel_journey_app/presentation/providers/home_provider.dart';
import 'package:travel_journey_app/presentation/widgets/category_chip_row.dart';
import 'package:travel_journey_app/presentation/widgets/fade_slide_in.dart';
import 'package:travel_journey_app/presentation/widgets/place_promo_card.dart';
import 'package:travel_journey_app/presentation/widgets/search_bar_row.dart';
import 'package:travel_journey_app/routing/router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeProvider(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: .expand,
      children: [
        Positioned.fill(
          child: Image.asset(AssetRes.bgOverlay, fit: .cover),
        ),
        SafeArea(
          child: Padding(
            padding: .fromLTRB(
              NumberConstant.horizontalPadding,
              NumberConstant.homeHeaderSpacing,
              NumberConstant.horizontalPadding,
              NumberConstant.bottomNavHeight + NumberConstant.bottomNavBottomInset,
            ),
            child: Column(
              crossAxisAlignment: .start,
              spacing: NumberConstant.homeContentSpacing,
              children: [
                FadeSlideIn(child: _buildHeader()),
                FadeSlideIn(
                  delay: MotionConstant.staggerStep,
                  child: Text(StringConst.homeTitle, style: AppTextStyles.homeTitle),
                ),
                FadeSlideIn(
                  delay: MotionConstant.staggerStep * 2,
                  child: SearchBarRow(
                    onTap: () => context.push(NamedRoutes.search.routeName),
                  ),
                ),
                FadeSlideIn(
                  delay: MotionConstant.staggerStep * 3,
                  child: Consumer<HomeProvider>(
                    builder: (context, provider, _) => CategoryChipRow(
                      categories: AppData.categories,
                      selectedIndex: provider.selectedCategoryIndex,
                      onSelected: provider.selectCategory,
                    ),
                  ),
                ),
                Expanded(
                  child: FadeSlideIn(
                    delay: MotionConstant.staggerStep * 4,
                    beginOffset: const Offset(0, MotionConstant.slideDistance * 1.25),
                    child: _buildCarousel(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(text: StringConst.greetingHello, style: AppTextStyles.greetingLight),
                const TextSpan(text: ' '),
                TextSpan(text: StringConst.userName, style: AppTextStyles.greetingBold),
                TextSpan(text: StringConst.greetingWave, style: AppTextStyles.greetingBold),
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            shape: .circle,
            border: .all(color: AppColors.borderWhite8, width: 1.5),
          ),
          padding: .all(NumberConstant.avatarPadding),
          child: ClipOval(
            child: Image.asset(AppData.userAvatar, height: 44),
          ),
        ),
      ],
    );
  }

  Widget _buildCarousel(BuildContext context) {
    final provider = context.watch<HomeProvider>();
    final places = AppData.homePlaces;
    final pageController = provider.pageController;

    return PageView.builder(
      controller: pageController,
      itemCount: places.length,
      itemBuilder: (context, index) {
        final place = places[index];
        return AnimatedBuilder(
          animation: pageController,
          builder: (context, child) {
            final page = _currentPage(pageController);
            final delta = page - index;
            final distance = delta.abs();
            final scale = (1 - distance * 0.08).clamp(
              MotionConstant.carouselNeighborScale,
              1.0,
            );
            final opacity = (1 - distance * 0.22).clamp(
              MotionConstant.carouselNeighborOpacity,
              1.0,
            );
            final parallax = delta * MotionConstant.carouselParallaxFactor;

            return Padding(
              padding: .symmetric(horizontal: NumberConstant.carouselItemPadding),
              child: Transform.scale(
                scale: scale,
                child: Opacity(
                  opacity: opacity,
                  child: PlacePromoCard(
                    place: place,
                    enableParallax: true,
                    parallaxOffset: parallax,
                    isFavorite: provider.isFavorite(place.id),
                    onFavoriteTap: () => provider.toggleFavorite(place.id),
                    onTap: () => context.push(NamedRoutes.placePath(place.id)),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  double _currentPage(PageController controller) {
    if (controller.hasClients && controller.position.haveDimensions) {
      return controller.page ?? controller.initialPage.toDouble();
    }
    return controller.initialPage.toDouble();
  }
}
