import 'package:real_state/features/core/domain/entity/paginated_params.dart';

class RealEstateGetParams extends PaginationParams {
  double? minPrice, maxPrice;
  String? title;
  bool? isFavourite;
  String? city;

  RealEstateGetParams({
    required super.skip,
    required super.limit,
    this.minPrice,
    this.maxPrice,

    this.title,
    this.isFavourite,
    this.city,
  });
}
