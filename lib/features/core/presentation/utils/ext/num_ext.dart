import 'package:flutter/cupertino.dart';
import 'package:real_state/features/core/presentation/utils/ext/format_to_normal.dart';

extension NumExt on num {
  Widget width() => SizedBox(height: 0, width: toDouble(),);
  Widget height() => SizedBox(height: toDouble(), width: 0,);
  String formatPrice(BuildContext context){
    return "${toStringAsFixed(0).formatNum()} \$" ;
  }
}
