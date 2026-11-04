class PlaceModel {
  final String id;
  final String name;
  final double price;
  final String location;
  final double rating;
  final String imageAsset;
  final String overview;
  final String openHours;
  final String weather;
  final List<String> galleryAssets;

  const PlaceModel({
    required this.id,
    required this.name,
    required this.price,
    required this.location,
    required this.rating,
    required this.imageAsset,
    required this.overview,
    required this.openHours,
    required this.weather,
    required this.galleryAssets,
  });

  String get formattedPrice => '\$${price.toStringAsFixed(2)}';
}
