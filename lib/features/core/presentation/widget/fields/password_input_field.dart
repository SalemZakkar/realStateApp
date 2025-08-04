import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:real_state/features/core/presentation/utils/ext/dynamic_svg_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/themes/app_theme.dart';

import '../../../../../generated/generated_assets/assets.gen.dart';
import '../../../../../generated/translation/translations.dart';
import '../../utils/input_validator.dart';
import '../buttons/inkwell_without_feedback.dart';

class PasswordInputField extends StatefulWidget {
  final TextInputAction? textInputAction;

  // final GlobalKey<FormState> formKey;
  final bool hasAtLeastOneCapitalLetter;
  final bool hasAtLeastOneSmallLetter;
  final bool hasAtLeast8Chars;
  final bool hasAtLeastOneSymbol;
  final bool hasAtLeastOneSmallLetterAndOneCapital;
  final bool hasConfirmPassword;
  final FocusNode? passwordFocus;
  final void Function(String password)? onChange;
  final void Function(String)? onFieldSubmitted;
  final TextEditingController passwordController;
  final String? title;

  const PasswordInputField({
    super.key,
    this.textInputAction,
    this.hasAtLeastOneCapitalLetter = false,
    this.hasAtLeast8Chars = false,
    this.hasAtLeastOneSmallLetter = false,
    this.hasAtLeastOneSymbol = false,
    this.hasAtLeastOneSmallLetterAndOneCapital = false,
    this.hasConfirmPassword = false,
    this.onFieldSubmitted,
    this.passwordFocus,
    required this.passwordController,
    this.onChange,
    this.title,
    // required this.formKey,
  });

  @override
  State<PasswordInputField> createState() => _PasswordControlState();
}

class _PasswordControlState extends State<PasswordInputField> {
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
  MultiValidator _multiValidator = MultiValidator([]);
  bool? _hasNotMatched;

  @override
  void initState() {
    if (widget.passwordFocus != null) {
      _passwordFocus = widget.passwordFocus!;
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _multiValidator = MultiValidator([
        RequiredValidator(errorText: context.translation.fieldRequiredMessage),
      ]);
      if (widget.hasAtLeast8Chars) {
        _multiValidator.validators.add(
          MinLengthValidator(
            8,
            errorText: Translations.of(
              context,
            )!.shouldContainAtLeast8Characters,
          ),
        );
      }
      if (widget.hasAtLeastOneCapitalLetter) {
        _multiValidator.validators.add(
          HasAtLeastOneCapitalLetter(
            errorText: Translations.of(
              context,
            )!.shouldContainAtLeastOneCapitalLetter,
          ),
        );
      }
      if (widget.hasAtLeastOneSmallLetter) {
        _multiValidator.validators.add(
          HasAtLeastOneSmallLetter(
            errorText: Translations.of(
              context,
            )!.shouldContainAtLeastOneSmallLetter,
          ),
        );
      }
      if (widget.hasAtLeastOneSymbol) {
        _multiValidator.validators.add(
          HasAtLeastOneSymbol(
            errorText: Translations.of(context)!.shouldContainAtLeastOneSymbol,
          ),
        );
      }
      if (widget.hasAtLeastOneSmallLetterAndOneCapital) {
        _multiValidator.validators.add(
          HasAtLeastOneSmallLetterAndOneCapital(
            errorText: Translations.of(
              context,
            )!.shouldContainAtLeastOneSmallLetterAndOneCapitalLetter,
          ),
        );
      }
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tr = Translations.of(context)!;
    return SingleChildScrollView(
      child: Column(
        children: [
          PasswordInputFieldWidget(
            withMessage: _multiValidator.validators.length == 1,
            textInputAction: (widget.hasConfirmPassword)
                ? TextInputAction.next
                : TextInputAction.done,
            focusNode: _passwordFocus,
            controller: widget.passwordController,
            labelText: tr.password,
            validator: (value) {
              return _multiValidator(value);
            },
            onChange: (password) {
              // widget.formKey.currentState!.validate();
              if (widget.passwordController.text ==
                  _confirmPasswordController.text) {
                _hasNotMatched = false;

                setState(() {});
              } else {
                _hasNotMatched = true;
                setState(() {});
              }
              setState(() {});
              if (widget.onChange != null) widget.onChange!(password);
            },
          ),
          if (widget.hasConfirmPassword)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: PasswordInputFieldWidget(
                withMessage: _multiValidator.validators.length == 1,
                focusNode: _confirmPasswordFocus,

                controller: _confirmPasswordController,
                labelText: tr.confirmPassword,
                onChange: (confirmPassword) {
                  // widget.formKey.currentState!.validate();
                  if (widget.passwordController.text ==
                      _confirmPasswordController.text) {
                    _hasNotMatched = false;

                    setState(() {});
                  } else {
                    _hasNotMatched = true;
                    setState(() {});
                  }
                },
                validator: (value) {
                  if (_hasNotMatched ?? true) {
                    return '';
                  } else {
                    return null;
                  }
                },
              ),
            ),
          if (widget.hasAtLeast8Chars)
            _PasswordRuleWidget(
              text: Translations.of(context)!.shouldContainAtLeast8Characters,
              state: _multiValidator.checkFieldValidator(
                ValidatorType.minLength,
              ),
            ),
          if (widget.hasAtLeastOneSmallLetterAndOneCapital)
            _PasswordRuleWidget(
              text: Translations.of(
                context,
              )!.shouldContainAtLeastOneSmallLetterAndOneCapitalLetter,
              state: _multiValidator.checkFieldValidator(
                ValidatorType.hasAtLeastOneSmallLetterAndOneCapital,
              ),
            ),
          if (widget.hasAtLeastOneCapitalLetter)
            _PasswordRuleWidget(
              text: Translations.of(
                context,
              )!.shouldContainAtLeastOneCapitalLetter,
              state: _multiValidator.checkFieldValidator(
                ValidatorType.hasAtLeastOneCapitalLetter,
              ),
            ),
          if (widget.hasAtLeastOneSmallLetter)
            _PasswordRuleWidget(
              text: Translations.of(
                context,
              )!.shouldContainAtLeastOneSmallLetter,
              state: _multiValidator.checkFieldValidator(
                ValidatorType.hasAtLeastOneSmallLetter,
              ),
            ),
          if (widget.hasAtLeastOneSymbol)
            _PasswordRuleWidget(
              text: Translations.of(context)!.shouldContainAtLeastOneSymbol,
              state: _multiValidator.checkFieldValidator(
                ValidatorType.hasAtLeastOneSymbol,
              ),
            ),
          if (widget.hasConfirmPassword)
            _PasswordRuleWidget(
              text: Translations.of(context)!.matchedPassword,
              state: _hasNotMatched != null ? !_hasNotMatched! : null,
            ),
        ],
      ),
    );
  }

  String generatePassword() {
    String upper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    String lower = 'abcdefghijklmnopqrstuvwxyz';
    String numbers = '1234567890';
    String symbols = '!@#\$%^&*()<>,./';
    int passLength = 2;
    String password = '';
    Random rand = Random();

    for (int i = 0; i < passLength; i++) {
      int index = 0;
      index = rand.nextInt(lower.split('').toList().length);
      password += lower.split('')[index];
      index = rand.nextInt(upper.split('').toList().length);
      password += upper.split('')[index];
      index = rand.nextInt(symbols.split('').toList().length);
      password += symbols.split('')[index];
      index = rand.nextInt(numbers.split('').toList().length);
      password += numbers.split('')[index];
    }
    return password;
  }
}

class _PasswordRuleWidget extends StatelessWidget {
  final String text;
  final bool? state;

  const _PasswordRuleWidget({required this.text, this.state});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 4),
      child: Row(
        children: [
          Icon(
            state == null
                ? Icons.radio_button_off_rounded
                : Icons.circle_rounded,
            color: state == false
                ? Theme.of(context).colorScheme.error
                : Theme.of(context).primaryColor,
            size: 12,
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: 12,
              color: state == false
                  ? Theme.of(context).colorScheme.error
                  : Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

class PasswordInputFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputAction? textInputAction;
  final void Function(String value)? onChange;
  final String? Function(String?)? validator;
  final FocusNode focusNode;
  final bool withMessage;

  const PasswordInputFieldWidget({
    required this.controller,
    required this.labelText,
    required this.focusNode,
    this.textInputAction,
    this.onChange,
    this.validator,
    required this.withMessage,
    super.key,
  });

  @override
  State<PasswordInputFieldWidget> createState() =>
      _PasswordInputFieldWidgetState();
}

class _PasswordInputFieldWidgetState extends State<PasswordInputFieldWidget> {
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: [_PasswordFormatter()],
      autovalidateMode: AutovalidateMode.onUserInteraction,
      focusNode: widget.focusNode,
      enableInteractiveSelection: true,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.labelText,
        errorMaxLines: 1,
        suffixIcon: InkWellWithoutFeedback(
          onTap: _toggle,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child:
                (_obscureText ? Assets.icons.visible : Assets.icons.invisible)
                    .dynamicSVGColor(
                      context,
                      color: context.appColorSchema.shapeColors.iconColor,
                    ),
          ),
        ),
        errorText: null,
        errorStyle: TextStyle(
          fontSize: widget.withMessage ? null : 0,
          // height: 0.7,
        ),
      ),
      keyboardType: TextInputType.visiblePassword,
      obscureText: _obscureText,
      textInputAction: widget.textInputAction ?? TextInputAction.done,
      validator: widget.validator,
      onChanged: widget.onChange,
    );
  }
}

class _PasswordFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      composing: newValue.composing,
      selection: newValue.selection,
      text: newValue.text.replaceAll(" ", ""),
    );
  }
}
