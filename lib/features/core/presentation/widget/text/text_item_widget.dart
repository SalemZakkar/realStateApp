import 'package:flutter/material.dart';

class TextItemWidget extends StatelessWidget {
  final String title;
  final String description;
  final EdgeInsets? padding;
  final TextStyle? descriptionStyle;
  final TextStyle? titleStyle;

  const TextItemWidget({
    super.key,
    required this.title,
    required this.description,
    this.padding,
    this.descriptionStyle,
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(title)),
        Text(
          description,
          style: descriptionStyle ?? Theme.of(context).textTheme.titleSmall,
        ),
      ],
    );
  }
}
