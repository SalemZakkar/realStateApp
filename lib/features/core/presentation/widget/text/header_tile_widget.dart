import 'package:flutter/material.dart';

class HeaderTileWidget extends StatelessWidget {
  final String title;
  final EdgeInsets? padding;
  final TextStyle? style;

  const HeaderTileWidget({
    super.key,
    required this.title,
    this.padding,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      padding: padding ?? const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: style ?? Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
