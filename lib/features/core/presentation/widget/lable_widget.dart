import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/utils/ext/dynamic_svg_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/num_ext.dart';
import 'package:real_state/generated/generated_assets/assets.gen.dart';

class LabelWidget extends StatefulWidget {
  final String title;
  final SvgGenImage svgGenImage;
  final Widget child;
  final Color? color;
  final String? instructions;

  const LabelWidget({
    super.key,
    this.color,
    required this.title,
    required this.child,
    required this.svgGenImage,
    this.instructions,
  });

  @override
  State<LabelWidget> createState() => _LabelWidgetState();
}

class _LabelWidgetState extends State<LabelWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            widget.svgGenImage.dynamicSVGColor(
              context,
              width: 20,
              color: widget.color ?? Theme.of(context).primaryColor,
            ),
            8.width(),
            Flexible(
              child: Text(
                widget.title,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
            ),
          ],
        ),
        if(widget.instructions != null)...[
          8.height(),
          Text(widget.instructions!)
        ],
        8.height(),
        widget.child,
      ],
    );
  }
}
