import 'package:travel_journey_app/constants/string_const.dart';
import 'package:travel_journey_app/core/asset_res.dart';
import 'package:travel_journey_app/core/models/category_filter_model.dart';
import 'package:travel_journey_app/core/models/detail_tab_model.dart';
import 'package:travel_journey_app/core/models/place_model.dart';

class AppData {
  static const userName = StringConst.userName;
  static const userAvatar = AssetRes.avatar;
  static const searchQuery = 'Thailand';

  static const categories = [
    CategoryFilterModel(
      id: 'place',
      label: StringConst.categoryPlace,
      iconAsset: AssetRes.icLocationMarker,
    ),
    CategoryFilterModel(
      id: 'flight',
      label: StringConst.categoryFlight,
      iconAsset: AssetRes.icFlight,
    ),
    CategoryFilterModel(
      id: 'hotels',
      label: StringConst.categoryHotels,
      iconAsset: AssetRes.icHotels,
    ),
  ];

  static const detailTabs = [
    DetailTabModel(id: 'details', label: StringConst.tabDetails),
    DetailTabModel(id: 'route', label: StringConst.tabRouteList),
    DetailTabModel(id: 'review', label: StringConst.tabReview),
  ];

  static const places = [
    PlaceModel(
      id: 'klong-chao-beach',
      name: 'Klong Chao Beach',
      price: 65,
      location: 'Thailand',
      rating: 4.9,
      imageAsset: AssetRes.placeKlongChao,
      overview:
          'Klong Chao Beach has long been a magnet for travelers and surfers from all over the world. With its golden-white sand and stunning sunsets, it’s the perfect spot for sunbathing, swimming, or simply relaxing by the shore.',
      openHours: '24 Hours',
      weather: '29°C',
      galleryAssets: [
        AssetRes.placeDetailHero,
        AssetRes.placeKlongChao,
        AssetRes.placeCarouselLeft,
        AssetRes.placeCarouselRight,
      ],
    ),
    PlaceModel(
      id: 'grand-palace',
      name: 'Grand Palace',
      price: 25,
      location: 'Bangkok',
      rating: 4.8,
      imageAsset: AssetRes.placeGrandPalace,
      overview:
          'The Grand Palace is a former royal residence in Bangkok and one of Thailand’s most iconic landmarks, known for its ornate temples, golden spires, and rich cultural heritage.',
      openHours: '8:30 AM - 3:30 PM',
      weather: '32°C',
      galleryAssets: [
        AssetRes.placeGrandPalace,
        AssetRes.placeDetailHero,
        AssetRes.placeWaterfall,
      ],
    ),
    PlaceModel(
      id: 'emerald-falls',
      name: 'Emerald Falls',
      price: 40,
      location: 'Thailand',
      rating: 4.7,
      imageAsset: AssetRes.placeWaterfall,
      overview:
          'Emerald Falls is a lush jungle escape with cascading water, cool mist, and scenic hiking trails perfect for nature lovers and photographers.',
      openHours: '6:00 AM - 6:00 PM',
      weather: '27°C',
      galleryAssets: [
        AssetRes.placeWaterfall,
        AssetRes.placeCarouselLeft,
        AssetRes.placeKlongChao,
      ],
    ),
    PlaceModel(
      id: 'phi-phi-cliffs',
      name: 'Phi Phi Cliffs',
      price: 55,
      location: 'Thailand',
      rating: 4.6,
      imageAsset: AssetRes.placeCarouselLeft,
      overview:
          'Dramatic limestone cliffs meet turquoise waters at Phi Phi, offering boat tours, viewpoints, and unforgettable coastal scenery.',
      openHours: '24 Hours',
      weather: '30°C',
      galleryAssets: [
        AssetRes.placeCarouselLeft,
        AssetRes.placeCarouselRight,
        AssetRes.placeKlongChao,
      ],
    ),
    PlaceModel(
      id: 'maya-cove',
      name: 'Maya Cove',
      price: 70,
      location: 'Thailand',
      rating: 4.8,
      imageAsset: AssetRes.placeCarouselRight,
      overview:
          'Maya Cove is a secluded bay framed by towering cliffs, ideal for swimming, kayaking, and soaking in the calm island atmosphere.',
      openHours: '7:00 AM - 5:00 PM',
      weather: '29°C',
      galleryAssets: [
        AssetRes.placeCarouselRight,
        AssetRes.placeKlongChao,
        AssetRes.placeDetailHero,
      ],
    ),
  ];

  static List<PlaceModel> get homePlaces => [
        places[3],
        places[0],
        places[4],
      ];

  static List<PlaceModel> get searchPlaces => [
        places[1],
        places[0],
        places[2],
        places[3],
      ];

  static PlaceModel placeById(String id) {
    return places.firstWhere(
      (place) => place.id == id,
      orElse: () => places.first,
    );
  }
}
