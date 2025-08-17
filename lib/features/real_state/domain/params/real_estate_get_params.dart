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
  });
}
