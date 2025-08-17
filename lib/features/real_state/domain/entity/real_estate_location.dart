import 'package:google_maps_flutter/google_maps_flutter.dart';

class RealEstateLocation {
  double lat, lng;

  RealEstateLocation({required this.lat, required this.lng});

  LatLng get latLng => LatLng(lat, lng);
}
