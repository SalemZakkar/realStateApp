import 'package:intl_phone_number_input/intl_phone_number_input.dart';

extension Util on PhoneNumber {
  String get readDialCode => phoneNumber!.split(dialCode!).last;
}
