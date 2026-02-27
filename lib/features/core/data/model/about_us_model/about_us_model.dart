import 'package:json_annotation/json_annotation.dart';
import 'package:real_state/features/core/domain/entity/about_us.dart';

part 'about_us_model.g.dart';

@JsonSerializable()
class AboutUsModel {
  String? facebookLink;
  String? instagramLink;
  @JsonKey(defaultValue: [])
  List<String> phones;
  String? description;
  String? termsAndConditions;
  String? privacyPolicy;

  AboutUsModel({
    this.privacyPolicy,
    this.description,
    this.facebookLink,
    this.instagramLink,
    required this.phones,
    this.termsAndConditions,
  });

  factory AboutUsModel.fromJson(Map<String, dynamic> json) =>
      _$AboutUsModelFromJson(json);
}

extension MapToDomain on AboutUsModel {
  AboutUs toDomain() => AboutUs(
    phones: phones,
    description: description,
    facebookLink: facebookLink,
    instagramLink: instagramLink,
    privacyPolicy: privacyPolicy,
    termsAndConditions: termsAndConditions,
  );
}
