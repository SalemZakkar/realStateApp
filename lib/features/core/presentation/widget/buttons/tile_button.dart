import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/utils/ext/num_ext.dart';

class TileButton extends StatelessWidget {
  final Widget? image;
  final Widget? icon;
  final String title;

  const TileButton({
    super.key,
    this.image,
    required this.title,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (image != null) ...[image!, 8.width()],
        Expanded(
          child: Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
        ),
        if (icon != null) ...[icon!],
      ],
    );
  }
}
