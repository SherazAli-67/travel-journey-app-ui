import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:travel_journey_app/constants/number_constant.dart';
import 'package:travel_journey_app/constants/string_const.dart';
import 'package:travel_journey_app/core/app_colors.dart';
import 'package:travel_journey_app/core/app_data.dart';
import 'package:travel_journey_app/core/app_textstyles.dart';
import 'package:travel_journey_app/core/asset_res.dart';
import 'package:travel_journey_app/presentation/providers/search_provider.dart';
import 'package:travel_journey_app/presentation/widgets/circle_icon_button.dart';
import 'package:travel_journey_app/presentation/widgets/place_promo_card.dart';
import 'package:travel_journey_app/presentation/widgets/search_bar_row.dart';
import 'package:travel_journey_app/routing/router.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchProvider(),
      child: const _SearchView(),
    );
  }
}

class _SearchView extends StatelessWidget {
  const _SearchView();

  @override
  Widget build(BuildContext context) {
    final places = AppData.searchPlaces;
    return Scaffold(
      body: Stack(
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
                0,
              ),
              child: Column(
                crossAxisAlignment: .start,
                spacing: NumberConstant.homeContentSpacing,
                children: [
                  _buildHeader(context),
                  const SearchBarRow(),
                  Text(
                    '${StringConst.resultsFoundPrefix} ${places.length} ${StringConst.resultsFoundPlacesIn} “${AppData.searchQuery}”',
                    style: AppTextStyles.resultsCount,
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: .only(bottom: NumberConstant.sectionSpacing),
                      itemCount: places.length,
                      itemBuilder: (context, index) {
                        final place = places[index];
                        return Padding(
                          padding: .only(bottom: NumberConstant.sectionSpacing),
                          child: Consumer<SearchProvider>(
                            builder: (context, provider, _) => PlacePromoCard(
                              place: place,
                              aspectRatio: NumberConstant.searchCardAspectRatio,
                              isFavorite: provider.isFavorite(place.id),
                              onFavoriteTap: () => provider.toggleFavorite(place.id),
                              onTap: () => context.push(NamedRoutes.placePath(place.id)),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      alignment: .center,
      children: [
        Align(
          alignment: .centerLeft,
          child: CircleIconButton(
            iconAsset: AssetRes.icArrowBack,
            backgroundColor: AppColors.black05,
            onTap: () => context.pop(),
          ),
        ),
        Text(StringConst.searchTitle, style: AppTextStyles.screenTitle,),
      ],
    );
  }
}
