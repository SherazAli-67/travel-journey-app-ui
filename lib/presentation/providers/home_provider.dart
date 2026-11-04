import 'package:flutter/material.dart';
import 'package:travel_journey_app/constants/number_constant.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider() {
    pageController = PageController(
      viewportFraction: NumberConstant.carouselViewportFraction,
      initialPage: 1,
    );
  }

  late final PageController pageController;
  int selectedCategoryIndex = 0;
  final Set<String> favoriteIds = {};

  void selectCategory(int index) {
    if (selectedCategoryIndex == index) return;
    selectedCategoryIndex = index;
    notifyListeners();
  }

  void toggleFavorite(String placeId) {
    if (favoriteIds.contains(placeId)) {
      favoriteIds.remove(placeId);
    } else {
      favoriteIds.add(placeId);
    }
    notifyListeners();
  }

  bool isFavorite(String placeId) => favoriteIds.contains(placeId);

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
