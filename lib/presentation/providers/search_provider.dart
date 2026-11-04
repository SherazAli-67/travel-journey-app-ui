import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  final Set<String> favoriteIds = {};

  void toggleFavorite(String placeId) {
    if (favoriteIds.contains(placeId)) {
      favoriteIds.remove(placeId);
    } else {
      favoriteIds.add(placeId);
    }
    notifyListeners();
  }

  bool isFavorite(String placeId) => favoriteIds.contains(placeId);
}
