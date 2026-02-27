
class AboutUs {
  String? facebookLink;
  String? instagramLink;
  List<String> phones;
  String? description;
  String? termsAndConditions;
  String? privacyPolicy;

  AboutUs({
    this.privacyPolicy,
    this.description,
    this.facebookLink,
    this.instagramLink,
    required this.phones,
    this.termsAndConditions,
  });
}
