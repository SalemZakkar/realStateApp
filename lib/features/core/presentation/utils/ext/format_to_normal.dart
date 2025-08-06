import 'dart:math';

import 'package:intl/intl.dart';

extension FormatToNormal on String {
  ///For Example
  ///
  ///'oneTime'=> One Time
  ///
  /// 'OneTime'=> One Time
  ///
  /// 'onetime'=> Onetime
  ///
  /// 'onetime vds'=> Onetime vds
  String formatToNormal() {
    String result = replaceAll('_', ' ').capitalize;

    // for (int i = 1; i < length; i++) {
    //   if (this[i] == this[i].toUpperCase()) {
    //     result += ' ${this[i].toUpperCase()}';
    //   } else {
    //     result += this[i];
    //   }
    // }

    return result;
  }

  String get capitalize {
    return (length > 1) ? this[0].toUpperCase() + substring(1) : toUpperCase();
  }

  String get addLeadingTimeZero {
    if (length == 1) {
      return '0$this';
    }
    return this;
  }

  String formatNumberWithPrecision(int precision) {
    bool isF = true;
    int number = 0;
    if (int.tryParse(this) != null) {
      number = int.parse(this);
      isF = false;
    }
    if (isF || precision >= length || number < 0) {
      return this;
    }
    const suffixes = [
      'K',
      'M',
      'B',
      'T'
    ]; // Thousand, Million, Billion, Trillion
    if (number < 1000) {
      return number.toString(); // No formatting needed for numbers < 1000
    }

    String formatted = '';

    int exp = 0;

    for (int i = 0; i < suffixes.length; i++) {
      if (number >= pow(10, 3 + 3 * i)) {
        exp = i;
      }
    }

    double res = number / pow(10, 3 + 3 * exp);
    formatted = res.toStringAsFixed(precision);
    int k = formatted.length;
    for (int i = formatted.length - 1; i >= 0; i--) {
      if (formatted[i] == '0') {
        k = i;
      } else {
        break;
      }
    }
    formatted = formatted.substring(0, k);
    if (formatted[formatted.length - 1] == '.') {
      formatted = formatted.replaceAll('.', '');
    }

    return '$formatted${suffixes[exp]}'; // Add the appropriate suffix
  }

  String formatNum() {
    final formatter = NumberFormat("#,##0");
    bool isF = true;
    int number = 0;
    if (int.tryParse(this) != null) {
      number = int.parse(this);
      isF = false;
    }
    if (isF || number.abs() < 0) {
      return this;
    }
    int k = int.parse(this).abs();
    String res = formatter.format(k);
    if (number < 0) {
      res = '-$res';
    }
    return res;
  }

  String phoneNumber() {
    if (startsWith('0')) {
      return this;
    }
    return '0$this';
  }

  String? get valOrNull {
    return trim().isNotEmpty ? this : null;
  }
}
