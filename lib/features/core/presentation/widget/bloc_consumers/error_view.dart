import 'package:flutter/material.dart';
import 'package:real_state/features/core/domain/entity/failures.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';

class ErrorView extends StatefulWidget {
  final Function? onRetry;
  final Failure? failure;
  final bool showErrorInBodyPage;

  const ErrorView({
    super.key,
    this.onRetry,
    this.failure,
    this.showErrorInBodyPage = false,
  });

  @override
  State<ErrorView> createState() => _ErrorViewState();
}

class _ErrorViewState extends State<ErrorView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            widget.failure?.getError(context) ?? context.translation.errorMessage,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ),
        if (widget.onRetry != null) ...[
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => widget.onRetry!(),
            child: Text(context.translation.retry),
          ),
        ],
      ],
    );
  }
}
