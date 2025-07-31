import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:real_state/features/core/domain/entity/failures.dart';
import 'package:real_state/features/core/presentation/cubit/base_states/base_state.dart';

import '../dialogs/dialog_util.dart';

class ScreenLoader<T> extends StatefulWidget {
  final BlocBase<BaseState<T>> cubit;
  final bool autoDispose;
  final ValueChanged<T>? onSuccess;
  final ValueChanged<Failure>? onError;
  final Widget? loader;
  final Widget child;
  final bool? isFloating;
  final bool withSuccess;

  const ScreenLoader({
    super.key,
    this.autoDispose = true,
    required this.cubit,
    this.loader,
    this.onError,
    this.onSuccess,
    required this.child,
    this.isFloating,
    this.withSuccess = true,
  });

  @override
  State<ScreenLoader<T>> createState() => _ScreenLoaderState<T>();
}

class _ScreenLoaderState<T> extends State<ScreenLoader<T>> {
  @override
  void dispose() {
    super.dispose();
    if (widget.autoDispose) {
      widget.cubit.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: widget.cubit,
      listener: (context, BaseState<T> state) {
        if (state.isInProgress) {
          DialogUtil(context: context).showLoadingDialog();
        } else if (state.isSuccess) {
          if(context.canPop()){
            context.pop();
          }
          widget.onSuccess?.call(state.item as T);
          if (widget.withSuccess) {
            // WidgetsBinding.instance.addPostFrameCallback((e) {
            DialogUtil(context: context).showSuccessDialog();
            // });
          }
        } else if (state.isFailure) {
          if(context.canPop()){
            context.pop();
          }
          DialogUtil(context: context).showFailDialog(
            failure: state.failure,
            isFloating: widget.isFloating ?? false,
          );
          widget.onError?.call(state.failure!);
        } else {}
      },
      child: widget.child,
    );
  }
}
