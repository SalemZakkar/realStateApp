import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/themes/app_theme.dart';
import 'loading_dialog.dart';

class DialogUtil {
  BuildContext context;
  final bool canPop;
  final VoidCallback? onShow, onAccept, onCancel;

  DialogUtil({
    required this.context,
    this.canPop = true,
    this.onAccept,
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
  }

  Future<void> showSuccessDialog({String? message}) async {
    onShow?.call();
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      titleColor: Theme.of(context).textTheme.headlineSmall!.color!,
      textColor: Theme.of(context).textTheme.headlineSmall!.color!,
      title: message ?? context.translation.success,
      onConfirmBtnTap: () {
        context.pop();
        onAccept?.call();
      },
      backgroundColor: Theme.of(context).cardColor,
      confirmBtnText: context.translation.ok,
      confirmBtnColor: context.appColorSchema.statusColors.success,
    );
  }

  Future<void> showFailDialog({
    Failure? failure,
    bool isFloating = false,
  }) async {
    onShow?.call();
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      titleColor: Theme.of(context).textTheme.headlineSmall!.color!,
      textColor: Theme.of(context).textTheme.headlineSmall!.color!,
      title: failure?.getError(context) ?? context.translation.errorMessage,
      onConfirmBtnTap: () {
        context.pop();
        onAccept?.call();
      },
      backgroundColor: Theme.of(context).cardColor,
      confirmBtnText: context.translation.ok,
      confirmBtnColor: context.appColorSchema.statusColors.fail,
    );
  }

  Future showConfirmDialog({String? title, required String message}) async {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.warning,
      cancelBtnText: context.translation.no,
      confirmBtnColor: Theme.of(context).primaryColor,
      confirmBtnText: context.translation.yes,
      backgroundColor: Theme.of(context).cardColor,
      showCancelBtn: true,
      text: message,
      title: title ?? context.translation.areUSure,
      titleColor: Theme.of(context).textTheme.headlineSmall!.color!,
      textColor: Theme.of(context).textTheme.headlineSmall!.color!,
      onConfirmBtnTap: () {
        context.pop();
        onAccept?.call();
      },
      onCancelBtnTap: () {
        context.pop();
        onCancel?.call();
      },
    );
  }

  // Future<void> showMessage({required String message}) async {
  //   await showDialog(
  //     context: context,
  //     builder: (context) {
  //       return MessageDialog(message: message);
  //     },
  //   );
  // }
}

class MainScreenLoaderDialogProvider extends ScreenLoaderDialogProvider {
  @override
  Future<void> showFailDialog({
    required BuildContext context,
    Failure? failure,
  }) async {
    await DialogUtil(context: context).showFailDialog(failure: failure);
  }

  @override
  Future<void> showLoadingDialog({
    required BuildContext context,
    bool? root,
  }) async {
    await DialogUtil(
      context: context,
      canPop: false,
    ).showLoadingDialog(root: root);
  }

  @override
  Future<void> showSuccessDialog({
    required BuildContext context,
    String? message,
  }) async {
    await DialogUtil(context: context).showSuccessDialog(message: message);
  }
}
