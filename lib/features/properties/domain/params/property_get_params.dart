import 'package:real_state/features/core/domain/params/base_pagination_params.dart';
import 'package:real_state/features/properties/domain/enum/property_enum.dart';

class PropertyGetParams extends BasePaginationParams {
  BaseParamsSortType? price;
  BaseParamsSortType? size;
  String? owner;
  String? city;
  PropertyType? propertyType;
  PropertyCategory? category;
  PropertyDeedType? propertyDeedType;
  bool? isFeature;
  PropertyStatus? status;
  bool? isSaved;

  @override
  void reset() {
    skip = 0;
    limit = 10;
    super.reset();
  }

  PropertyGetParams clone() => PropertyGetParams(
    limit: limit,
    skip: skip,
    category: category,
    city: city,
    isFeature: isFeature,
    owner: owner,
    price: price,
    propertyDeedType: propertyDeedType,
    propertyType: propertyType,
    size: size,
    status: status,
    isSaved: isSaved,
  );

  PropertyGetParams({
    this.status,
    this.propertyDeedType,
    this.propertyType,
    this.city,
    this.size,
    this.category,
    this.price,
    this.isFeature,
    this.owner,
    this.isSaved,
    super.skip,
    super.limit,
  });
}
