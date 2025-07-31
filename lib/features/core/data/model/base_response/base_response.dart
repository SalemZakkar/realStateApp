import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

@JsonSerializable(genericArgumentFactories: true, createToJson: false)
class BaseResponse<T> {
  final int? totalRecords;
  final T? data;
  final String? message;

  BaseResponse({this.totalRecords, this.data, this.message});

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$BaseResponseFromJson(json, fromJsonT);
}

// @JsonSerializable()
// class PaginationModel {
//   int limit;
//
//   PaginationModel(this.limit);
// }
