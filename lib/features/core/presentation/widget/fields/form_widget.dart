import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/utils/ext/num_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';

class FormWidget extends StatefulWidget {
  final String? errorMessage;
  final bool? valid;
  final Widget child;

  const FormWidget({
    super.key,
    this.errorMessage,
    this.valid,
    required this.child,
  });

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  @override
  Widget build(BuildContext context) {
    return FormField(
      validator: (v) {
        if (widget.valid == true) {
          return null;
        }
        return widget.errorMessage ?? context.translation.fieldRequiredMessage;
      },
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // padding: EdgeInsets.symmetric(vertical: 16),
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: widget.child,
            ),
            if (state.hasError) ...[
              8.height(),
              Text(state.errorText!, style: const TextStyle(color: Colors.red)),
            ],
          ],
        );
      },
    );
  }
}
