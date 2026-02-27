
import 'package:core_package/core_package.dart';

extension Util on PhoneNumber {
  String get readDialCode => phoneNumber!.split(dialCode!).last;
}
