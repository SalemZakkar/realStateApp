import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/utils/ext/num_ext.dart';

class HeaderText extends StatefulWidget {
  final String title;
  final String? desc;
  final TextStyle? textStyle, descStyle;
  final Widget? end;
  final double padding;

  final MainAxisAlignment mainAxisAlignment;

  const HeaderText({
    super.key,
    required this.title,
    this.textStyle,
    this.end,
    this.padding = 0,
    this.desc,
    this.descStyle,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });

  @override
  State<HeaderText> createState() => _HeaderTextState();
}

class _HeaderTextState extends State<HeaderText> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: widget.mainAxisAlignment,
      children: [
        (widget.padding).width(),
        Flexible(
          child: Text(
            widget.title,
            style: widget.textStyle ?? Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        if (widget.desc != null)
          Flexible(
            child: Text(
              widget.desc!,
              style: widget.descStyle ??
                  Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        if (widget.end != null) ...[
          widget.end!,
          widget.padding.width(),
        ],
      ],
    );
  }
}
