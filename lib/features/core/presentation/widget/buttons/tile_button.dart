import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/utils/ext/dynamic_svg_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/num_ext.dart';
import 'package:real_state/generated/generated_assets/assets.gen.dart';

class TileButton extends StatelessWidget {
  final dynamic image;
  final String title;
  final bool isSend;

  const TileButton({
    super.key,
    required this.image,
    required this.title,
    this.isSend = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (image is SvgGenImage) ...[
          (image as SvgGenImage).dynamicSVGColor(
            context,
            color: Theme.of(context).primaryColor,
            width: 24,
            height: 24,
          ),
        ],
        if (image is Widget) image,
        8.width(),
        Expanded(
          child: Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
        ),
        (isSend ? Assets.icons.send : Assets.icons.edit).dynamicSVGColor(
          context,
          color: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}

