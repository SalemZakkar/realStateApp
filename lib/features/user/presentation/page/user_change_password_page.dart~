import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/utils/ext/num_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/fields/password_input_field.dart';
import 'package:real_state/features/core/presentation/widget/text/header_text.dart';

import '../../../generated/generated_assets/assets.gen.dart';
import '../../core/presentation/widget/lable_widget.dart';

class UserChangePasswordPage extends StatefulWidget {
  static String path = '/user/changepassword';

  const UserChangePasswordPage({super.key});

  @override
  State<UserChangePasswordPage> createState() => _UserChangePasswordPageState();
}

class _UserChangePasswordPageState extends State<UserChangePasswordPage> {
  TextEditingController password = TextEditingController();
  TextEditingController currentPassword = TextEditingController();
  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        constraints: const BoxConstraints.expand(),
        child: Form(
          key: key,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderText(title: context.translation.changePassword),
                8.height(),
                Text(
                  context.translation.changeYourAccountPassword,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                32.height(),
                LabelWidget(
                  title: context.translation.currentPassword,
                  svgGenImage: Assets.icons.password,
                  child: PasswordInputField(
                    passwordController: currentPassword,
                  ),
                ),
                16.height(),
                LabelWidget(
                  title: context.translation.password,
                  svgGenImage: Assets.icons.password,
                  child: PasswordInputField(
                    passwordController: password,
                    hasConfirmPassword: true,
                    hasAtLeast8Chars: true,
                  ),
                ),
                16.height(),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      if (!key.currentState!.validate()) {
                        return;
                      }
                    },
                    child: Text(context.translation.continuE),
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
