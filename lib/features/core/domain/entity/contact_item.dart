import 'package:real_state/features/core/domain/enum/contact_type.dart';

class ContactItem {
  String value;
  ContactType type;
  String? title;

  ContactItem({required this.type, required this.value, this.title});
}
