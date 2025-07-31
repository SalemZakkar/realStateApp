import 'package:flutter/cupertino.dart';

extension NumExt on num {
  Widget width() => SizedBox(height: 0, width: toDouble(),);
  Widget height() => SizedBox(height: toDouble(), width: 0,);
}
