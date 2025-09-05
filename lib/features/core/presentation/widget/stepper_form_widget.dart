import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:real_state/features/core/presentation/utils/ext/num_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/stepper_widget.dart';

class StepperFormWidget extends StatefulWidget {
  const StepperFormWidget({
    super.key,
    this.onPageChanged,
    required this.stepTitles,
    required this.pages,
    required this.onDone,
    required this.controller,
    this.onNext,
    this.onBack,
    this.canBack,
  });

  final List<StepperItem> stepTitles;
  final ValueChanged<int>? onPageChanged;
  final List<Widget> pages;
  final VoidCallback onDone;
  final StepperFormWidgetController controller;
  final ValueChanged<int>? onNext, onBack;
  final bool Function(int page)? canBack;

  @override
  State<StepperFormWidget> createState() => _StepperFormWidgetState();
}

class _StepperFormWidgetState extends State<StepperFormWidget> {
  int page = 0;
  PageController pageController = PageController();

  void move(int k) {
    if (k >= widget.controller.page || k < 0) {
      return;
    }
    widget.controller.setPage(k);
  }

  @override
  void initState() {
    super.initState();
    widget.controller.setMax(widget.pages.length);
    widget.controller.addListener(() {
      setState(() {
        page = widget.controller.page;
        pageController.jumpToPage(page);
        widget.onPageChanged?.call(page);
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool hasEnd = page == widget.stepTitles.length - 1;
    bool hasBegun = page == 0;
    return PopScope(
      canPop: page == 0,
      onPopInvokedWithResult: (did, v) {
        if (hasBegun) {
          context.pop();
        } else {
          if (widget.canBack?.call(page) == false) {
            context.pop();
          }
          widget.controller.back();
          setState(() {});
        }
      },
      child: Container(
        constraints: const BoxConstraints.expand(),
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            StepperWidget(index: page, items: widget.stepTitles),
            32.height(),
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, i) {
                  return widget.pages[i];
                },
                controller: pageController,
                itemCount: widget.pages.length,
                physics: const NeverScrollableScrollPhysics(),
              ),
            ),
            8.height(),
            Row(
              children: [
                if (widget.canBack?.call(page) ?? true) ...[
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        if (hasBegun) {
                          context.pop();
                          return;
                        }
                        if (widget.onBack == null) {
                          widget.controller.back();
                        }
                        widget.onBack?.call(page);
                      },
                      child: Text(
                        page > 0
                            ? context.translation.back
                            : context.translation.cancel,
                      ),
                    ),
                  ),
                  8.width(),
                ],
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // disabledBackgroundColor: context.appColorSchema.grey,
                    ),
                    onPressed: () {
                      if (hasEnd) {
                        widget.onDone.call();
                        return;
                      }
                      if (widget.onNext == null) {
                        widget.controller.next();
                      }
                      widget.onNext?.call(page);
                    },
                    child: Text(
                      page == widget.stepTitles.length - 1
                          ? context.translation.done
                          : context.translation.next,
                    ),
                  ),
                ),
              ],
            ),
            8.height(),
          ],
        ),
      ),
    );
  }
}

class StepperFormWidgetController extends ChangeNotifier {
  int page = 0;

  late int max;

  void setMax(int k) {
    max = k;
    notifyListeners();
  }

  void setPage(int page) {
    if (page < 0 || page >= max) {
      return;
    }
    this.page = page;
    notifyListeners();
  }

  void next() {
    if (page >= max) {
      return;
    }
    page++;
    notifyListeners();
  }

  void back() {
    if (page <= 0) {
      return;
    }
    page--;
    notifyListeners();
  }
}
