import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:real_state/features/auth/domain/params/auth_sign_up_params.dart';
import 'package:real_state/features/auth/presentation/cubits/auth_sign_up_cubit.dart';
import 'package:real_state/features/core/presentation/page/legal_page.dart';
import 'package:real_state/features/core/presentation/utils/ext/num_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/bloc_consumers/screen_loader.dart';
import 'package:real_state/features/core/presentation/widget/buttons/inkwell_without_feedback.dart';
import 'package:real_state/features/core/presentation/widget/fields/form_widget.dart';
import 'package:real_state/generated/generated_assets/fonts.gen.dart';
import 'package:real_state/injection.dart';

import '../../../../generated/generated_assets/assets.gen.dart';
import '../../../core/presentation/utils/input_validator.dart';
import '../../../core/presentation/widget/fields/password_input_field.dart';
import '../../../core/presentation/widget/fields/phone_input_field.dart';
import '../../../core/presentation/widget/lable_widget.dart';
import '../../../core/presentation/widget/text/header_text.dart';

class AuthSignUpPage extends StatefulWidget {
  static const String path = '/auth/signUp';

  const AuthSignUpPage({super.key});

  @override
  State<AuthSignUpPage> createState() => _AuthSignUpPageState();
}

class _AuthSignUpPageState extends State<AuthSignUpPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  PhoneNumber phoneNumber = PhoneNumber();

  final key = GlobalKey<FormState>();

  var cubit = getIt<AuthSignUpCubit>();

  bool accept = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(Translations.of(context)!.logIn),
        // centerTitle: true,
      ),
      body: Form(
        key: key,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          constraints: const BoxConstraints.expand(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderText(title: context.translation.createAccount),
                8.height(),
                Text(
                  context.translation.welcomeToOurApplication,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                32.height(),
                LabelWidget(
                  title: context.translation.email,
                  svgGenImage: Assets.icons.email,
                  child: TextFormField(
                    textDirection: TextDirection.ltr,
                    decoration: InputDecoration(
                      hintText: context.translation.email,
                    ),
                    controller: email,
                    validator: EmailValidator(
                      errorText: context.translation.fieldRequiredMessage,
                    ).call,
                  ),
                ),
                16.height(),
                LabelWidget(
                  title: context.translation.name,
                  svgGenImage: Assets.icons.name,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: context.translation.name,
                    ),
                    controller: name,
                    validator: RequiredValidator(
                      errorText: context.translation.fieldRequiredMessage,
                    ).call,
                  ),
                ),
                16.height(),
                LabelWidget(
                  title: context.translation.phone,
                  svgGenImage: Assets.icons.phone,
                  child: PhoneInputFieldWidget(
                    filled: true,
                    onChanged: (v) {
                      phoneNumber = v;
                    },
                    initialPhoneNumber: phoneNumber,
                  ),
                ),
                16.height(),
                LabelWidget(
                  title: context.translation.password,
                  svgGenImage: Assets.icons.password,
                  child: PasswordInputField(
                    passwordController: password,
                    hasAtLeast8Chars: true,
                    hasConfirmPassword: true,
                  ),
                ),
                16.height(),
                FormWidget(valid: accept,child: InkWellWithoutFeedback(
                  onTap: () {
                    setState(() {
                      accept = !accept;
                    });
                  },
                  child: Row(
                    children: [
                      Icon(
                        accept
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: Theme.of(context).primaryColor,
                      ),
                      8.width(),
                      RichText(
                        text: TextSpan(
                          text: context.translation.iAccept,
                          style: TextStyle(fontFamily: FontFamily.cairo),
                          children: [
                            TextSpan(
                              text: " ${context.translation.privacyPolicy}",
                              style: TextStyle(fontWeight: FontWeight.w800),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.push(LegalPage.path);
                                },
                            ),
                            TextSpan(text: " ${context.translation.and}"),
                            TextSpan(
                              text:
                              " ${context.translation.termsAndConditions}",
                              style: TextStyle(fontWeight: FontWeight.w800),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.push(LegalPage.path);
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ) ,),
                16.height(),
                ScreenLoader(
                  cubit: cubit,
                  withSuccess: false,
                  onSuccess: (v) {
                    context.pop();
                    context.pop();
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        if (key.currentState!.validate()) {
                          cubit.exec(
                            params: AuthSignUpParams(
                              code: phoneNumber.dialCode,
                              phone: phoneNumber.parseNumber(),
                              name: name.text,
                              confirmPassword: password.text,
                              password: password.text,
                              email: email.text,
                            ),
                          );
                        }
                      },
                      child: Text(context.translation.createAccount),
                    ),
                  ),
                ),
                16.height(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(context.translation.alreadyHaveAccount)],
                ),
                16.height(),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: OutlinedButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: Text(context.translation.logIn),
                  ),
                ),
                16.height(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
