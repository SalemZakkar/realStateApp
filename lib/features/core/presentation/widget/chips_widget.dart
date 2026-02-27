import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:real_state/themes/app_theme.dart';

class ChipsWidget<T> extends StatefulWidget {
  final ValueChanged<T?> onSelect;
  final double spacing;
  final List<T> items;
  final String Function(T)? getString;
  final T? selected;

  const ChipsWidget({
    super.key,
    required this.onSelect,
    required this.spacing,
    this.getString,
    required this.items,
    this.selected,
  });

  @override
  State<ChipsWidget<T>> createState() => _ChipsWidgetState<T>();
}

class _ChipsWidgetState<T> extends State<ChipsWidget<T>> {
  bool sel(int i) {
    return widget.selected == widget.items[i];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.start,
        alignment: WrapAlignment.start,
        spacing: widget.spacing,
        runSpacing: widget.spacing,
        children: [
          for (int i = 0; i < widget.items.length; i++)
            InkWellWithoutFeedback(
              onTap: () {
                if (sel(i)) {
                  widget.onSelect.call(null);
                } else {
                  widget.onSelect.call(widget.items[i]);
                }
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: sel(i)
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                // alignment: Alignment.center,
                child: Text(
                  widget.getString?.call(widget.items[i]) ??
                      widget.items[i].toString(),
                  style: TextStyle(
                    color: sel(i)
                        ? context.appColorSchema.white
                        : Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
