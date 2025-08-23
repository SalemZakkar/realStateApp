import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class User {
  String name;
  String email;
  PhoneNumber phoneNumber;
  String id;
  bool isActive, isEmailVerified;
  String get formatNumber => "${phoneNumber.dialCode!} ${phoneNumber.phoneNumber!}";

  User({
    required this.phoneNumber,
    required this.name,
    required this.email,
    required this.id,
    required this.isActive,
    required this.isEmailVerified,
  });
}
