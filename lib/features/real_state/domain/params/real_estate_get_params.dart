import 'package:real_state/features/core/domain/entity/city.dart';
import 'package:real_state/features/core/domain/entity/paginated_params.dart';
import 'package:real_state/features/real_state/domain/enum/real_estate_category_type.dart';
import 'package:real_state/features/real_state/domain/enum/real_estate_property_deed_type.dart';
import 'package:real_state/features/real_state/domain/enum/real_estate_property_type.dart';

class RealEstateGetParams extends PaginationParams {
  double? minPrice, maxPrice;
  String? title;
  bool? isFavourite;
  City? city;
  RealEstatePropertyType? propertyType;
  RealEstatePropertyDeedType? propertyDeedType;
  RealEstateCategory? category;
  double? minSize;
  double? maxSize;
  bool? isFeatured;

  RealEstateGetParams clone() => RealEstateGetParams(
    isFeatured: isFeatured,
    minPrice: minPrice,
    maxPrice: maxPrice,
    title: title,
    isFavourite: isFavourite,
    city: city,
    propertyDeedType: propertyDeedType,
    propertyType: propertyType,
    category: category,
    maxSize: maxSize,
    minSize: minSize,
    skip: skip,
    limit: limit,
  );

  void setFromClone(RealEstateGetParams params) {
    minSize = params.minSize;
    maxSize = params.maxSize;
    minPrice = params.minPrice;
    maxPrice = params.maxPrice;
    title = params.title;
    isFeatured = params.isFeatured;
    propertyType = params.propertyType;
    propertyDeedType = params.propertyDeedType;
    city = params.city;
    category = params.category;
    skip = params.skip;
    limit = params.limit;
    title = params.title;
  }

  RealEstateGetParams({
    super.skip,
    super.limit,
    this.minPrice,
    this.maxPrice,
    this.title,
    this.isFavourite,
    this.city,
    this.category,
    this.minSize,
    this.maxSize,
    this.isFeatured,
    this.propertyDeedType,
    this.propertyType,
  });
}
