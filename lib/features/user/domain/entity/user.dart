
class User {
  String? name;
  String? phoneNumber;
  String id;
  bool isActive;
  bool isCompleted;
  String? image;

  User({
    required this.phoneNumber,
    required this.name,
    required this.id,
    required this.isActive,
    required this.isCompleted,
    this.image,
  });
}
