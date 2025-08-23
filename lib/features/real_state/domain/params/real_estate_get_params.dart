import 'package:real_state/features/core/domain/entity/city.dart';
import 'package:real_state/features/core/domain/entity/paginated_params.dart';
import 'package:real_state/features/real_state/domain/enum/category_type.dart';
import 'package:real_state/features/real_state/domain/enum/property_deed_type.dart';
import 'package:real_state/features/real_state/domain/enum/property_type.dart';

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
    page: page,
    limit: limit,
  );

  RealEstateGetParams({
    super.page,
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
