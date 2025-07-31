import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/themes/app_theme.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({
    super.key,
    required this.onChanged,
    this.localSearch = false,
    this.controller,
    this.focusNode,
    this.backgroundColor,
    this.suffixIcon,
    this.suffix,
    this.labelText,
    this.onPressedFilter,
    this.inputFormatters,
    this.keyboardType,
    this.hint,
  });

  final bool localSearch;
  final TextEditingController? controller;
  final void Function(String) onChanged;
  final Color? backgroundColor;
  final FocusNode? focusNode;
  final Widget? suffixIcon;
  final Widget? suffix;
  final String? labelText;
  final void Function()? onPressedFilter;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final String? hint;

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  Timer? _debounce;

  void delayTwoSecond(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(
      const Duration(milliseconds: 1200),
      () => widget.onChanged(value),
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            keyboardType: widget.keyboardType,
            focusNode: widget.focusNode,
            onChanged: (value) {
              if (widget.localSearch) {
                widget.onChanged(value);
              } else {
                delayTwoSecond(value);
              }
            },
            inputFormatters: widget.inputFormatters,
            controller: widget.controller,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(2),
              fillColor:
                  widget.backgroundColor ??
                  Theme.of(context).inputDecorationTheme.fillColor,
              labelText: widget.labelText ?? context.translation.search,
              hintText: widget.hint,
              hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: context.appColorSchema.textColors.hintAndDisable,
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12),
                child: Icon(Icons.search),
              ),
              suffixIcon: widget.suffixIcon,
              suffix: widget.suffix,
            ),
          ),
        ),
        // if (widget.onPressedFilter != null) ...[
        //   16.width(),
        //   SizedBox(
        //     height: 47,
        //     width: 47,
        //     child: OutlinedButton(
        //       style: ButtonStyle(
        //         backgroundColor: WidgetStateProperty.all(Colors.transparent),
        //         padding: WidgetStateProperty.all(const EdgeInsets.all(8)),
        //         side: WidgetStateProperty.all(
        //           BorderSide(color: context.appColorSchema.shapeColors.borderColor),
        //         ),
        //         shape: WidgetStateProperty.all(
        //           RoundedRectangleBorder(
        //             side: BorderSide(
        //               color: context.appColorSchema.shapeColors.borderColor,
        //             ),
        //             borderRadius: BorderRadius.circular(8),
        //           ),
        //         ),
        //         foregroundColor: WidgetStateProperty.all(Colors.transparent),
        //       ),
        //       onPressed: widget.onPressedFilter,
        //       child: Assets.icons.filter.path.dynamicSVGColor(context),
        //     ),
        //   ),
        // ],
      ],
    );
  }
}
