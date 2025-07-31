import 'package:flutter/material.dart';
import 'package:real_state/features/core/domain/enum/otp_reason.dart';
import 'package:real_state/features/core/presentation/utils/ext/num_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/text/header_text.dart';

import '../../../../generated/generated_assets/assets.gen.dart';
import '../utils/input_validator.dart';
import '../widget/lable_widget.dart';

class SendOtpPage extends StatefulWidget {
  static String path = '/auth/sendOtp';
  final OtpReason reason;

  const SendOtpPage({super.key, required this.reason});

  @override
  State<SendOtpPage> createState() => _SendOtpPageState();
}

class _SendOtpPageState extends State<SendOtpPage> {
  TextEditingController email = TextEditingController();
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
                HeaderText(
                  title: widget.reason == OtpReason.email
                      ? context.translation.verifyEmail
                      : context.translation.forgetPassword,
                ),
                8.height(),
                Text(
                  context.translation.enterYourEmailOtp,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                32.height(),
                LabelWidget(
                  title: context.translation.email,
                  svgGenImage: Assets.icons.email,
                  child: TextFormField(
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
