import 'package:flutter/material.dart';
import 'package:real_state/generated/translation/translations.dart';

extension Translation on BuildContext {
  Translations get translation => Translations.of(this)!;
}
