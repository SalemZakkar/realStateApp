import 'dart:async';

import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/utils/ext/num_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/string.dart';

class TimerDisableWidget extends StatefulWidget {
  final TimerDisableWidgetController controller;
  final Widget child;

  final Widget Function(BuildContext, String)? timerBuilder;

  const TimerDisableWidget({
    super.key,
    required this.controller,
    required this.child,
    this.timerBuilder,
  });

  @override
  State<TimerDisableWidget> createState() => _TimerDisableWidgetState();
}

class _TimerDisableWidgetState extends State<TimerDisableWidget> {
  Timer? timer;

  int time = 0;

  bool dis = false;

  @override
  void setState(VoidCallback fn) {
    if (!mounted) {
      return;
    }
    super.setState(fn);
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (widget.controller.going && !dis) {
        time = widget.controller.time;
        dis = true;
        setState(() {});
        timer = Timer.periodic(const Duration(seconds: 1), (t) {
          time--;
          setState(() {});
          if (time <= 0) {
            setState(() {
              dis = false;
              widget.controller.going = false;
              timer?.cancel();
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IgnorePointer(
          ignoring: dis,
          child: Opacity(opacity: dis ? 0.5 : 1, child: widget.child),
        ),
        if (dis) ...[
          8.height(),
          widget.timerBuilder?.call(
                context,
                '${(time ~/ 60).toString().addLeadingTimeZero}:${(time % 60).toInt().toString().addLeadingTimeZero}',
              ) ??
              Text(
                '${(time ~/ 60).toString().addLeadingTimeZero}:${(time % 60).toInt().toString().addLeadingTimeZero}',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
        ],
      ],
    );
  }
}

class TimerDisableWidgetController extends ChangeNotifier {
  bool going = false;
  int time = 0;

  void toggle(int time) {
    this.time = time;
    going = true;
    notifyListeners();
  }
}
