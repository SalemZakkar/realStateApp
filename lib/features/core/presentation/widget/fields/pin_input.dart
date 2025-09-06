import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:real_state/features/core/presentation/utils/ext/num_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/buttons/inkwell_without_feedback.dart';

class PinEntryTextField extends StatefulWidget {
  final int fields;
  final ValueChanged<String> onSubmit;

  const PinEntryTextField({
    super.key,
    required this.fields,
    required this.onSubmit,
  }) : assert(fields > 0);

  @override
  State createState() {
    return PinEntryTextFieldState();
  }
}

class PinEntryTextFieldState extends State<PinEntryTextField> {
  List<TextEditingController> controllers = [];
  List<FocusNode> focuses = [];
  int last = -1;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(widget.fields, (e) => TextEditingController());
    focuses = List.generate(widget.fields, (e) => FocusNode());
  }

  int getNext(int i) {
    if (i == widget.fields - 1) {
      return i;
    }
    return i + 1;
  }

  int getBefore(int i) {
    if (i == 0) {
      return i;
    }
    return i - 1;
  }

  void focus(int i) {
    for (int j = 0; j < widget.fields; j++) {
      focuses[j].unfocus();
    }
    focuses[i].requestFocus();
    last = i;
  }

  void getValue() {
    String txt = '';
    for (int i = 0; i < widget.fields; i++) {
      txt += controllers[i].text;
    }
    if (txt.length == widget.fields) {
      widget.onSubmit.call(txt);
    }
  }

  bool error = false;

  bool isNumeric(String val) {
    return double.tryParse(val) != null;
  }

  void autoFocus() {
    focus(getLast());
  }

  int getLast() {
    int i = controllers.length - 1;
    for (int j = 0; j < controllers.length; j++) {
      if (controllers[j].text.trim().isEmpty) {
        i = j;
        break;
      }
    }
    return i;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KeyboardListener(
            onKeyEvent: (val) {
              if (val.logicalKey == LogicalKeyboardKey.backspace &&
                  last != -1 &&
                  controllers[last].text.trim().isEmpty &&
                  val is KeyDownEvent) {
                focus(getBefore(last));
              }
            },
            focusNode: FocusNode(),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int i = 0; i < widget.fields; i++) ...[
                    Expanded(
                      child: InkWellWithoutFeedback(
                        onTap: () {
                          autoFocus();
                        },
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            errorMaxLines: 1,
                            errorStyle: TextStyle(fontSize: 0),
                          ),
                          ignorePointers: getLast() != i,
                          validator: (val) {
                            if (val == null || val.trim() == "") {
                              error = true;
                              return "";
                            }
                            setState(() {
                              error = false;
                            });
                            return null;
                          },
                          textInputAction: i == widget.fields - 1
                              ? TextInputAction.done
                              : TextInputAction.next,
                          controller: controllers[i],
                          focusNode: focuses[i],
                          onChanged: (val) {
                            setState(() {});
                            if (!isNumeric(val)) {
                              controllers[i].text = '';
                              return;
                            }
                            if (val.length >= widget.fields) {
                              focus(widget.fields - 1);
                              for (int k = 0; k < val.length; k++) {
                                if (k >= widget.fields) {
                                  break;
                                }
                                controllers[k].text = val[k];
                              }
                              getValue();
                            } else {
                              if (val.isEmpty) {
                                controllers[i].text = '';
                                focus(getBefore(i));
                              } else {
                                controllers[i].text = val[val.length - 1];
                                focus(getNext(i));
                              }
                            }
                            getValue();
                          },
                        ),
                      ),
                    ),
                    if (i != widget.fields - 1) 5.width(),
                  ],
                ],
              ),
            ),
          ),
          8.height(),
          if (error)
            Text(
              context.translation.fieldRequiredMessage,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
        ],
      ),
    );
  }
}
