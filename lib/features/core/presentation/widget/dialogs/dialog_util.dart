import 'package:flutter/material.dart';
import 'package:real_state/features/core/domain/entity/failures.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/themes/app_theme.dart';

import 'confirm_dialog.dart';
import 'loading_dialog.dart';

class DialogUtil {
  BuildContext context;
  final bool canPop;
  final VoidCallback? onShow, onDone, onCancel;

  DialogUtil({
    required this.context,
    this.canPop = true,
    this.onDone,
    this.onShow,
    this.onCancel,
  });

  Future<void> showLoadingDialog({bool? root}) async {
    onShow?.call();
    await showDialog(
      context: context,
      useRootNavigator: root ?? false,
      builder: (context) => const LoadingDialog(),
      barrierDismissible: false,
    );
    onDone?.call();
  }

  Future<void> showSuccessDialog({String? message}) async {
    onShow?.call();
    String m = message ?? context.translation.success;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check, color: context.appColorSchema.white),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                m,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: context.appColorSchema.white,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: context.appColorSchema.statusColors.success,
      ),
    );
    onDone?.call();
  }

  Future<void> showFailDialog({
    Failure? failure,
    bool isFloating = false,
  }) async {
    onShow?.call();
    String message =
        failure?.getError(context) ?? context.translation.errorMessage;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.error_outline, color: context.appColorSchema.white),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                message,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: context.appColorSchema.white,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: context.appColorSchema.statusColors.fail,
        behavior: isFloating ? SnackBarBehavior.floating : null,
      ),
    );
  }

  Future<void> showConfirmDialog({required String message}) async {
    await showDialog(
      context: context,
      builder: (context) {
        return ConfirmDialog(
          onAccept: () {
            onDone?.call();
          },
          message: message,
        );
      },
    );
  }
}
