import 'package:json_annotation/json_annotation.dart';
import 'package:real_state/features/ad_banner/domain/entity/ad_banner.dart';

part 'ad_banner_model.g.dart';

@JsonSerializable()
class AdBannerModel {
  String image;
  @JsonKey(name: 'value')
  String url;

  AdBannerModel({required this.url, required this.image});

  factory AdBannerModel.fromJson(Map<String, dynamic> json) =>
      _$AdBannerModelFromJson(json);

  AdBanner toDomain() => AdBanner(url: url, image: image);
}
