import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/widget/measure.dart';

class StepperWidget extends StatefulWidget {
  final List<StepperItem> items;
  final int? index;
  final Color? thumbColor, doneRailColor, unDoneRailColor;

  const StepperWidget({
    super.key,
    required this.items,
    this.index,
    this.doneRailColor,
    this.thumbColor,
    this.unDoneRailColor,
  });

  @override
  State<StepperWidget> createState() => _StepperWidgetState();
}

class _StepperWidgetState extends State<StepperWidget> {
  int level = 0;
  double thumb = 24;
  double padding = 36;
  List<double> cords = List.generate(1000, (i) => 0);
  double startX = 0;

  @override
  void initState() {
    super.initState();
    level = widget.index ?? 0;
  }

  @override
  void didUpdateWidget(covariant StepperWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.index != level) {
      setState(() {
        level = widget.index ?? 0;
      });
    }
  }

  @override
  void setState(VoidCallback fn) {
    if (!mounted) {
      return;
    }
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return MeasureSize(
          key: UniqueKey(),
          onChange: (val) {
            setState(() {
              startX = val.dx;
            });
          },
          child: SizedBox(
            height: thumb + 24,
            child: Stack(
              children: [
                Stack(
                  children: [
                    Positioned(
                      left: padding,
                      right: padding,
                      top: (thumb / 2) - 1,
                      child: SizedBox(
                        width: constraints.maxWidth,
                        child: Row(
                          children: [
                            for (int i = 0; i < widget.items.length - 1; i++)
                              Expanded(
                                child: Container(
                                  height: 2,

                                  // color: [Colors.blue, Colors.green, Colors.red][i % 3],
                                  color: level > i
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).dividerColor,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: padding,
                      right: padding,
                      child: SizedBox(
                        width: constraints.maxWidth,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            for (int i = 0; i < widget.items.length; i++)
                              MeasureSize(
                                onChange: (off) {
                                  setState(() {
                                    cords[i] = off.dx + thumb / 2;
                                  });
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      height: thumb,
                                      width: thumb,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: level == i
                                            ? Theme.of(context).primaryColor
                                            : level < i
                                            ? Theme.of(context).dividerColor
                                            : Theme.of(context).primaryColor,
                                      ),
                                      alignment: Alignment.center,
                                      child: level == i || level < i
                                          ? Container(
                                              width: thumb / 2,
                                              height: thumb / 2,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                              ),
                                            )
                                          : Icon(
                                              Icons.check,
                                              size: 16,
                                              color: Theme.of(
                                                context,
                                              ).scaffoldBackgroundColor,
                                            ),
                                    ),

                                    // 4.height(),
                                    // Text(widget.items[i].title)
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                for (int i = 0; i < widget.items.length; i++)
                  if (cords.first != cords[widget.items.length - 1])
                    Positioned(
                      top: thumb + 4,
                      left:
                          cords[i] -
                          ((MediaQuery.of(context).size.width /
                                  widget.items.length) /
                              2) -
                          startX,
                      child: Container(
                        width:
                            (MediaQuery.of(context).size.width /
                            widget.items.length),
                        alignment: Alignment.center,
                        // color: [Colors.blue, Colors.green, Colors.red][i % 3],
                        child: Text(
                          widget.items[i].title,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class StepperItem {
  String title;

  StepperItem(this.title);
}
