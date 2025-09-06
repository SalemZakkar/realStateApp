import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:real_state/features/auth/domain/params/auth_sign_in_params.dart';
import 'package:real_state/features/auth/presentation/cubits/auth_sign_in_cubit.dart';
import 'package:real_state/features/auth/presentation/page/auth_signup_page.dart';
import 'package:real_state/features/core/domain/enum/otp_reason.dart';
import 'package:real_state/features/core/presentation/page/send_otp_page.dart';
import 'package:real_state/features/core/presentation/utils/ext/num_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/utils/input_validator.dart';
import 'package:real_state/features/core/presentation/widget/bloc_consumers/screen_loader.dart';
import 'package:real_state/features/core/presentation/widget/fields/password_input_field.dart';
import 'package:real_state/features/core/presentation/widget/lable_widget.dart';
import 'package:real_state/features/core/presentation/widget/text/header_text.dart';
import 'package:real_state/injection.dart';
import 'package:real_state/themes/app_theme.dart';

import '../../../../generated/generated_assets/assets.gen.dart' show Assets;

class AuthLoginPage extends StatefulWidget {
  static const String path = '/auth/login';

  const AuthLoginPage({super.key});

  @override
  State<AuthLoginPage> createState() => _AuthLoginPageState();
}

class _AuthLoginPageState extends State<AuthLoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  var cubit = getIt<AuthSignInCubit>();
  final key = GlobalKey<FormState>();

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
                HeaderText(title: context.translation.logIn),
                8.height(),
                Text(
                  context.translation.enterYourEmailAndPassword,
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
                    validator: RequiredValidator(
                      errorText: context.translation.fieldRequiredMessage,
                    ).call,
                  ),
                ),
                16.height(),
                LabelWidget(
                  title: context.translation.password,
                  svgGenImage: Assets.icons.password,
                  child: PasswordInputField(
                    passwordController: password,
                    hasAtLeast8Chars: true,
                  ),
                ),
                16.height(),
                ScreenLoader(
                  cubit: cubit,
                  onSuccess: (v) {
                    context.pop();
                  },

                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        if (key.currentState!.validate()) {
                          cubit.exec(
                            params: AuthSignInParams(
                              email: email.text,
                              password: password.text,
                            ),
                          );
                        }
                      },
                      child: Text(context.translation.logIn),
                    ),
                  ),
                ),
                16.height(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(context.translation.doNotHaveAccount)],
                ),
                16.height(),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: OutlinedButton(
                    onPressed: () {
                      context.push(AuthSignUpPage.path);
                    },
                    child: Text(context.translation.createAccount),
                  ),
                ),
                16.height(),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: context.appColorSchema.statusColors.fail,
                      ),
                      foregroundColor: context.appColorSchema.statusColors.fail,
                      overlayColor: context.appColorSchema.statusColors.fail,
                    ),
                    onPressed: () {
                      context.push(SendOtpPage.path, extra: OtpReason.password);
                    },
                    child: Text(context.translation.forgetPassword),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
