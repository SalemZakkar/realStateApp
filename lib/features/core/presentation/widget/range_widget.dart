import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';

class RangeWidget extends StatefulWidget {
  final double min, max;
  final int division;

  final String Function(double) readValue;
  final RangeValues? initial;
  final void Function(double, double?) onChanged;

  const RangeWidget({
    super.key,
    required this.max,
    required this.min,
    required this.onChanged,
    required this.readValue,
    this.initial,
    required this.division,
  });

  @override
  State<RangeWidget> createState() => _RangeWidgetState();
}

class _RangeWidgetState extends State<RangeWidget> {
  late RangeValues priceRange;

  @override
  void initState() {
    super.initState();
    priceRange = widget.initial ?? RangeValues(widget.min, widget.max);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RangeSlider(
          divisions: widget.division,
          values: priceRange,
          onChanged: (v) {
            setState(() {
              priceRange = v;
            });
            widget.onChanged(v.start, v.end == widget.max ? null : v.end);
          },
          min: widget.min.toDouble(),
          max: widget.max.toDouble(),
          labels: RangeLabels(context.translation.min, context.translation.max),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                widget.readValue(priceRange.start),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Flexible(
              child: Text(
                priceRange.end == widget.max
                    ? '∞'
                    : widget.readValue(priceRange.end),

                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
