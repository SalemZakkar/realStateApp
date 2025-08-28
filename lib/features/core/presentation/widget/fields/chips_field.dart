import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/utils/ext/num_ext.dart';
import 'package:real_state/features/core/presentation/widget/buttons/inkwell_without_feedback.dart';
import 'package:real_state/features/core/presentation/widget/fields/form_widget.dart';
import 'package:real_state/features/core/presentation/widget/text/header_text.dart';
import 'package:real_state/themes/app_theme.dart';

class ChipsSingleField<T> extends StatefulWidget {
  final bool required;
  final List<T> values;
  final ValueChanged<T?> onChanged;
  final String title;
  final double spacing;
  final T? initial;
  final String Function(T)? getString;

  const ChipsSingleField({
    super.key,
    required this.title,
    required this.required,
    required this.onChanged,
    required this.values,
    this.spacing = 8,
    this.initial,
    this.getString,
  });

  @override
  State<ChipsSingleField<T>> createState() => _ChipsSingleFieldState<T>();
}

class _ChipsSingleFieldState<T> extends State<ChipsSingleField<T>> {
  bool sel(int i) {
    return value == widget.values[i];
  }

  T? value;

  @override
  void initState() {
    super.initState();
    value = widget.initial;
  }

  @override
  Widget build(BuildContext context) {
    return FormWidget(
      valid: value != null || !widget.required,
      child: Column(
        children: [
          HeaderText(title: widget.title),
          8.height(),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              alignment: WrapAlignment.start,
              spacing: widget.spacing,
              runSpacing: widget.spacing,
              children: [
                for (int i = 0; i < widget.values.length; i++)
                  InkWellWithoutFeedback(
                    onTap: () {
                      if (sel(i)) {
                        value = null;
                        widget.onChanged.call(null);
                      } else {
                        value = widget.values[i];
                        widget.onChanged.call(widget.values[i]);
                      }
                      setState(() {});
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
                        widget.getString?.call(widget.values[i]) ??
                            widget.values[i].toString(),
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
          ),
        ],
      ),
    );
  }
}
