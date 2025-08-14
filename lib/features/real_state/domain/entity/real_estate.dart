import 'package:real_state/features/core/domain/entity/city.dart';
import 'package:real_state/features/real_state/domain/entity/real_estate_location.dart';

import '../enum/category_type.dart';
import '../enum/property_deed_type.dart';
import '../enum/property_type.dart';

class RealEstate {
  final String id;
  final String title;
  double price;
  City city;
  String neighborhood;
  String? address;
  RealEstateLocation location;
  double size;
  int room;
  int bathrooms;
  int propertyAge;
  List<String> images;
  bool isFavourite;
  PropertyType propertyType;
  String? description;
  Category category;
  PropertyDeedType propertyDeedType;

  RealEstate({
    required this.id,
    required this.title,
    required this.price,
    required this.city,
    required this.neighborhood,
    this.address,
    required this.location,
    required this.propertyType,
    required this.size,
    required this.room,
    required this.bathrooms,
    required this.propertyAge,
    required this.images,
    this.isFavourite = false,
    this.description,
    required this.propertyDeedType,
    required this.category,
  });
}
