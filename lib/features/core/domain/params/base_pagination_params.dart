import 'package:core_package/core_package.dart';
import 'package:json_annotation/json_annotation.dart';

class BasePaginationParams extends PaginationParams {
  @override
  void reset() {}
  int? skip;
  int? limit;

  BasePaginationParams({
    this.skip,
    this.limit,
  });
}

enum BaseParamsSortType {
  @JsonValue('DESC')
  desc,
  @JsonValue('ASC')
  asc,
}
