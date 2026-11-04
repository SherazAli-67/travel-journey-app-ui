import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:travel_journey_app/constants/number_constant.dart';
import 'package:travel_journey_app/constants/string_const.dart';
import 'package:travel_journey_app/core/app_colors.dart';
import 'package:travel_journey_app/core/app_data.dart';
import 'package:travel_journey_app/core/app_textstyles.dart';
import 'package:travel_journey_app/core/asset_res.dart';
import 'package:travel_journey_app/presentation/providers/home_provider.dart';
import 'package:travel_journey_app/presentation/widgets/category_chip_row.dart';
import 'package:travel_journey_app/presentation/widgets/circle_icon_button.dart';
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
          child: Image.asset(AssetRes.bgOverlay, fit: .cover,),
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
                _buildHeader(),
                Text(StringConst.homeTitle, style: AppTextStyles.homeTitle,),
                SearchBarRow(onTap: () => context.push(NamedRoutes.search.routeName),),
                Consumer<HomeProvider>(
                  builder: (context, provider, _) => CategoryChipRow(
                    categories: AppData.categories,
                    selectedIndex: provider.selectedCategoryIndex,
                    onSelected: provider.selectCategory,
                  ),
                ),
                Expanded(child: _buildCarousel(context)),
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
        Row(
          spacing: NumberConstant.chipGap + 4,
          children: [
            CircleIconButton(
              iconAsset: AssetRes.icNotification,
              backgroundColor: AppColors.black05,
              showBadge: true,
            ),
            Container(
              decoration: BoxDecoration(
                shape: .circle,
                border: .all(color: AppColors.borderWhite8, width: 1.5),
              ),
              padding: .all(NumberConstant.avatarPadding),
              child: ClipOval(
                child: Image.asset(
                  AppData.userAvatar,
                  fit: .cover,
                  width: 44,
                  height: 44,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCarousel(BuildContext context) {
    final provider = context.watch<HomeProvider>();
    final places = AppData.homePlaces;
    return PageView.builder(
      controller: provider.pageController,
      itemCount: places.length,
      itemBuilder: (context, index) {
        final place = places[index];
        return Padding(
          padding: .symmetric(horizontal: NumberConstant.carouselItemPadding),
          child: PlacePromoCard(
            place: place,
            isFavorite: provider.isFavorite(place.id),
            onFavoriteTap: () => provider.toggleFavorite(place.id),
            onTap: () => context.push(NamedRoutes.placePath(place.id)),
          ),
        );
      },
    );
  }
}
