import 'package:real_state/features/core/domain/enum/contact_type.dart';

class ContactItem {
  String value;
  ContactType type;

  ContactItem({required this.type, required this.value});
}
