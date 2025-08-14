import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/utils/ext/num_ext.dart';
import 'package:real_state/features/core/presentation/widget/buttons/inkwell_without_feedback.dart';

class SliderStep extends StatefulWidget {
  final int length;
  final int index;
  final ValueChanged<int>? onTap;

  const SliderStep({
    super.key,
    required this.length,
    required this.index,
    this.onTap,
  });

  @override
  State<SliderStep> createState() => _SliderStepState();
}

class _SliderStepState extends State<SliderStep> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < widget.length; i++) ...[
          InkWellWithoutFeedback(
            onTap: (){
              widget.onTap?.call(i);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 24,
              height: 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: i == widget.index
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).primaryColor.withValues(alpha: 0.3),
              ),
            ),
          ),
          4.width(),
        ],
      ],
    );
  }
}
