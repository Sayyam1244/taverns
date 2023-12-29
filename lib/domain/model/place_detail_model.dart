class PlaceDetailsModel {
  final double latitude;
  final double longitude;

  PlaceDetailsModel({
    required this.latitude,
    required this.longitude,
  });

  factory PlaceDetailsModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> geometry = json['result']['geometry'];
    final Map<String, dynamic> location = geometry['location'];

    return PlaceDetailsModel(
      latitude: location['lat']?.toDouble() ?? 0.0,
      longitude: location['lng']?.toDouble() ?? 0.0,
    );
  }

  @override
  String toString() {
    return 'PlaceDetailsModel(latitude: $latitude, longitude: $longitude)';
  }
}
