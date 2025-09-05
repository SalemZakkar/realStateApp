import 'package:real_state/features/core/domain/entity/city.dart';
import 'package:real_state/features/real_state/domain/entity/real_estate_location.dart';
import 'package:real_state/features/real_state/domain/enum/real_estate_category_type.dart';
import 'package:real_state/features/real_state/domain/enum/real_estate_post_status.dart';
import 'package:real_state/features/real_state/domain/enum/real_estate_property_deed_type.dart';
import 'package:real_state/features/real_state/domain/enum/real_estate_property_type.dart';
import 'package:real_state/features/real_state/domain/enum/real_estate_status.dart';

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
  int? propertyAge;
  List<String> images;
  bool isFavourite;
  RealEstatePropertyType propertyType;
  String? description;
  RealEstateCategory category;
  RealEstatePropertyDeedType propertyDeedType;
  bool isFeature;
  String? owner;
  RealEstatePostStatus postStatus;
  RealEstateStatus status;
  int floor;
  int stock;
  String? rejectReason;

  bool get editable =>
      (postStatus == RealEstatePostStatus.pending ||
          postStatus == RealEstatePostStatus.rejected) &&
      status == RealEstateStatus.available;

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
    this.propertyAge,
    required this.images,
    this.isFavourite = false,
    this.description,
    required this.propertyDeedType,
    required this.category,
    this.isFeature = false,
    this.owner,
    required this.status,
    required this.postStatus,
    required this.floor,
    required this.stock,
    this.rejectReason,
  });
}
