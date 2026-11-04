import 'package:flutter/material.dart';

class PlaceDetailProvider extends ChangeNotifier {
  PlaceDetailProvider() {
    pageController = PageController();
  }

  late final PageController pageController;
  int galleryIndex = 0;
  int selectedTabIndex = 0;
  bool isFavorite = false;

  void setGalleryIndex(int index) {
    if (galleryIndex == index) return;
    galleryIndex = index;
    notifyListeners();
  }

  void selectTab(int index) {
    if (selectedTabIndex == index) return;
    selectedTabIndex = index;
    notifyListeners();
  }

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
