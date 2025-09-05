import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:real_state/features/real_state/data/model/real_estate_location_model/real_estate_location_model.dart';

class RealEstateLocation {
  double lat, lng;

  RealEstateLocation({required this.lat, required this.lng});

  LatLng get latLng => LatLng(lat, lng);

  RealEstateLocationModel toData() =>
      RealEstateLocationModel(lat: lat, lng: lng);
}
