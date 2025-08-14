import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';

class RegularBottomSheetLayout extends StatelessWidget {
  const RegularBottomSheetLayout({
    super.key,
    required this.body,
    this.enableDrag = true,
    this.padding,
    this.leading,
    this.actions,
    this.height,
    this.title,
    this.doneTxt,
    this.cancelTxt,
    this.onDone,
    this.onCancel,
    this.backgroundColor,
    this.enableDoneBtn = true,
    this.bodyConstraints,
  });

  final Widget body;
  final bool enableDrag;
  final EdgeInsetsDirectional? padding;
  final List<Widget>? actions;
  final double? height;
  final String? title;
  final Widget? leading;
  final String? doneTxt;
  final String? cancelTxt;
  final void Function()? onDone;
  final void Function()? onCancel;
  final Color? backgroundColor;
  final bool enableDoneBtn;
  final BoxConstraints? bodyConstraints;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      height: height,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(24),
          topLeft: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Align(
          //   alignment: Alignment.center,
          //   child: Container(
          //     width: 40,
          //     height: 4,
          //     decoration: BoxDecoration(
          //       borderRadius: const BorderRadius.all(Radius.circular(8)),
          //       color: Theme.of(context).appColors.grey,
          //     ),
          //   ),
          // ),
          Padding(
            padding: EdgeInsetsDirectional.only(
              top: 8,
              bottom: 12,
              start: padding == null ? 0 : 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (leading != null) leading!,
                if (title != null)
                  Expanded(
                    child: Text(
                      title!,
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                if (actions != null) Row(children: actions!),
              ],
            ),
          ),
          Flexible(
            child: Container(
              constraints:
                  bodyConstraints ??
                  BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height / 2,
                  ),
              child: body,
            ),
          ),
          if (onCancel == null && onDone == null)
            ...[]
          else ...[
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Row(
                children: [
                  if (onCancel != null) ...[
                    Expanded(
                      child: OutlinedButton(
                        onPressed: onCancel,
                        child: Text(
                          cancelTxt ?? context.translation.cancel,
                        ),
                      ),
                    ),
                    if (onDone != null) const SizedBox(width: 22),
                  ],
                  if (onDone != null)
                    Expanded(
                      child: Opacity(
                        opacity: enableDoneBtn ? 1 : 0.5,
                        child: IgnorePointer(
                          ignoring: !enableDoneBtn,
                          child: ElevatedButton(
                            onPressed: onDone,
                            child: Text(doneTxt ?? context.translation.done),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
