import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:real_state/features/core/presentation/utils/ext/num_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/stepper_widget.dart';

class StepperFormWidget extends StatefulWidget {
  const StepperFormWidget({
    super.key,
    required this.onPageChanged,
    required this.pageCanNext,
    required this.stepTitles,
    required this.pages,
    required this.onDone,
  });

  final List<StepperItem> stepTitles;
  final ValueChanged<int> onPageChanged;
  final bool Function(int) pageCanNext;
  final List<Widget> pages;
  final VoidCallback onDone;

  @override
  State<StepperFormWidget> createState() => _StepperFormWidgetState();
}

class _StepperFormWidgetState extends State<StepperFormWidget> {
  int page = 0;
  PageController pageController = PageController();

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
          pageController.jumpToPage(page - 1);
          page--;
          widget.onPageChanged(page);
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
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      if (hasBegun) {
                        context.pop();
                        return;
                      }
                      pageController.jumpToPage(page - 1);
                      setState(() {
                        page--;
                      });
                      widget.onPageChanged(page);
                    },
                    child: Text(
                      page > 0
                          ? context.translation.back
                          : context.translation.cancel,
                    ),
                  ),
                ),
                8.width(),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // disabledBackgroundColor: context.appColorSchema.grey,
                    ),
                    onPressed: () {
                      if (!widget.pageCanNext(page)) {
                        return;
                      }
                      if (hasEnd) {
                        widget.onDone();
                        return;
                      }
                      pageController.jumpToPage(page + 1);
                      setState(() {
                        page++;
                      });
                      widget.onPageChanged(page);
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
          ],
        ),
      ),
    );
  }
}
