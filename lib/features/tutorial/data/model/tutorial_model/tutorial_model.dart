import 'package:json_annotation/json_annotation.dart';
import 'package:real_state/features/tutorial/domain/entity/tutorial.dart';

part 'tutorial_model.g.dart';

@JsonSerializable()
class TutorialModel {
  String title;
  String url;
  String image;

  TutorialModel({required this.url, required this.title, required this.image});

  Tutorial toDomain() => Tutorial(url: url, title: title, image: image);

  factory TutorialModel.fromJson(Map<String, dynamic> json) =>
      _$TutorialModelFromJson(json);
}
