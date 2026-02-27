import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';

extension U on num {
  String formatPrice(BuildContext context) {
    return "${toStringAsFixed(0).formatNum()} ${context.translation.dollar}";
  }
}
