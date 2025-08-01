import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/themes/app_theme.dart';

class ConfirmDialog extends StatefulWidget {
  final VoidCallback onAccept;
  final VoidCallback? onCancel;
  final String message;
  final Color? foregroundColor;
  final String? acceptText;
  final String? cancelText;
  final Widget? title;

  const ConfirmDialog({
    super.key,
    required this.onAccept,
    this.onCancel,
    required this.message,
    this.foregroundColor,
    this.acceptText,
    this.cancelText,
    this.title,
  });

  @override
  State<ConfirmDialog> createState() => _ConfirmDialogState();
}

class _ConfirmDialogState extends State<ConfirmDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: widget.title,
      content: Text(widget.message , style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600),),
      backgroundColor: Theme.of(context).cardColor,
      actionsPadding: const EdgeInsets.all(16),
      actions: [
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 91, minHeight: 41),
          // width: 91,
          // height: 41,
          child: OutlinedButton(
            onPressed: () {
              widget.onCancel?.call();
              context.pop();
            },
            style: OutlinedButton.styleFrom(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              padding: const EdgeInsets.all(8),
              side: BorderSide(
                width: 1,
                color: Theme.of(context).textTheme.labelSmall!.color!,
              ),
            ),
            child: Text(
              widget.cancelText ?? context.translation.cancel,
              style: Theme.of(
                context,
              ).textTheme.labelSmall!.copyWith(fontSize: 15 , color: context.appColorSchema.textColors.primaryText),
            ),
          ),
        ),
        // 2.width(),
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 91, minHeight: 41),
          // width: 91,
          // height: 41,
          child: ElevatedButton(
            onPressed: () {
              widget.onAccept.call();
              context.pop();
            },

            child: Text(
              widget.acceptText ?? context.translation.yes,

            ),
          ),
        ),
      ],
    );
  }
}
