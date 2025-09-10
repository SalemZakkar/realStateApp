import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_state/features/core/presentation/cubit/base_states/base_state.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';

import '../../../domain/entity/failures.dart';
import 'error_view.dart';
import 'loader.dart';

class ConsumerWidget<T> extends StatefulWidget {
  final BlocBase<BaseState<T>> cubit;
  final bool autoDispose;
  final Widget Function(BuildContext context)? loadingBuilder;
  final ValueChanged<T>? onDataReceived;
  final ValueChanged<Failure>? onError;
  final Widget Function(BuildContext context, T t) childBuilder;
  final VoidCallback? onRetry;
  final String? customMessage;
  final Map<ServerErrorCode, String>? customMessages;
  final bool? showErrorInBodyPage;
  final Widget Function(BuildContext context, Failure failure)? errorBuilder;

  const ConsumerWidget({
    super.key,
    required this.cubit,
    required this.childBuilder,
    this.autoDispose = true,
    this.loadingBuilder,
    this.onError,
    this.onDataReceived,
    required this.onRetry,
    this.customMessage,
    this.customMessages,
    this.showErrorInBodyPage,
    this.errorBuilder,
  });

  @override
  State<ConsumerWidget<T>> createState() => _ConsumerWidgetState<T>();
}

class _ConsumerWidgetState<T> extends State<ConsumerWidget<T>> {
  @override
  void dispose() {
    super.dispose();
    if (widget.autoDispose) {
      widget.cubit.close();
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.cubit.state.isSuccess) {
      WidgetsBinding.instance.addPostFrameCallback((e) {
        widget.onDataReceived?.call(widget.cubit.state.item as T);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      listener: (context, BaseState<T> state) {
        if (state.isSuccess) {
          widget.onDataReceived?.call(state.item as T);
        }
        if (state.isFailure) {
          widget.onError?.call(state.failure!);
        }
      },
      bloc: widget.cubit,
      builder: (context, BaseState<T> state) {
        if (state.isInProgress) {
          return widget.loadingBuilder?.call(context) ?? const Loader();
        }
        if (state.isFailure) {
          return widget.errorBuilder?.call(context, state.failure!) ??
              ErrorView(
                failure: state.failure!,
                onRetry: widget.onRetry,
                showErrorInBodyPage: widget.showErrorInBodyPage ?? false,
              );
        }
        if (state.isSuccess) {
          if (state.item is List && (state.item as List).isEmpty) {
            return Center(child: Text(context.translation.noData));
          }
          return widget.childBuilder.call(context, state.item as T);
        }
        return const SizedBox();
      },
    );
  }
}
