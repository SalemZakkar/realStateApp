import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:real_state/features/auth/presentation/page/auth_otp_page.dart';
import 'package:real_state/features/core/presentation/utils/ext/dynamic_svg_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/home/presentation/page/home_page.dart';

import '../../../../generated/generated_assets/assets.gen.dart' show Assets;

class AuthLoginPage extends StatefulWidget {
  static const String path = '/auth/login';
  final bool? withBack;

  const AuthLoginPage({super.key, this.withBack});

  @override
  State<AuthLoginPage> createState() => _AuthLoginPageState();
}

class _AuthLoginPageState extends State<AuthLoginPage> {
  final key = GlobalKey<FormState>();
  String? phone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.translation.logIn)),
      body: Form(
        key: key,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          constraints: const BoxConstraints.expand(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.translation.enterYourPhoneNumber,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                32.height(),
                LabelWidget(
                  title: context.translation.phone,
                  leading: Assets.icons.phone.dynamicSVGColor(
                    context,
                    color: Theme.of(context).primaryColor,
                  ),
                  child: PhoneInputFieldWidget(
                    filled: true,
                    onChanged: (v) {
                      phone = v.phoneNumber;
                    },
                    // initialPhoneNumber: phoneNumber,
                  ),
                ),
                16.height(),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      if (key.currentState!.validate()) {
                        context.push(AuthOtpPage.path, extra: phone);
                      }
                    },
                    child: Text(context.translation.continuE),
                  ),
                ),
                if (widget.withBack != false) ...[
                  8.height(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: OutlinedButton(
                      onPressed: () {
                        context.go(HomePage.path);
                      },
                      child: Text(context.translation.continueAsGuest),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
