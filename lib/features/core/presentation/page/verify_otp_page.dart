import 'package:flutter/material.dart';
import 'package:real_state/features/auth/presentation/cubits/auth_send_otp_cubit.dart';
import 'package:real_state/features/auth/presentation/cubits/auth_verify_otp_cubit.dart';
import 'package:real_state/features/core/domain/entity/otp_status.dart';
import 'package:real_state/features/core/domain/enum/otp_reason.dart';
import 'package:real_state/features/core/presentation/utils/ext/num_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/bloc_consumers/screen_loader.dart';
import 'package:real_state/features/core/presentation/widget/fields/password_input_field.dart';
import 'package:real_state/features/core/presentation/widget/fields/pin_input.dart';
import 'package:real_state/features/core/presentation/widget/text/header_text.dart';
import 'package:real_state/features/core/presentation/widget/timer_disable_widget.dart';
import 'package:real_state/injection.dart';

import '../../../../generated/generated_assets/assets.gen.dart';
import '../widget/lable_widget.dart';

class VerifyOtpPageParams {
  final OtpReason reason;
  final String email;

  VerifyOtpPageParams({required this.reason, required this.email});
}

class VerifyOtpPage extends StatefulWidget {
  static String path = '/auth/verifyOtp';
  final VerifyOtpPageParams params;

  const VerifyOtpPage({super.key, required this.params});

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TimerDisableWidgetController controller = TimerDisableWidgetController();
  var sendEmail = getIt<AuthSendOtpCubit>();
  var verifyEmail = getIt<AuthVerifyOtpCubit>();
  final key = GlobalKey<FormState>();
  String otp = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((e) {
      if (widget.params.reason == OtpReason.email) {
        sendEmail.exec(email: widget.params.email);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ScreenLoader<OtpStatus>(
        withSuccess: false,
        cubit: sendEmail,
        onSuccess: (v) {
          if (DateTime.now().isBefore(v.nextDate)) {
            controller.toggle(v.nextDate.difference(DateTime.now()).inSeconds);
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          constraints: const BoxConstraints.expand(),
          child: Form(
            key: key,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderText(
                    title: widget.params.reason == OtpReason.email
                        ? context.translation.verifyEmail
                        : context.translation.forgetPassword,
                  ),
                  8.height(),
                  Text(
                    "${context.translation.enterYourCode}${widget.params.email}",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  32.height(),
                  LabelWidget(
                    title: context.translation.code,
                    svgGenImage: Assets.icons.otp,
                    child: PinEntryTextField(
                      fields: 6,
                      onSubmit: (v) {
                        otp = v;
                      },
                    ),
                  ),
                  if (widget.params.reason == OtpReason.password) ...[
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
                  ],
                  16.height(),
                  ScreenLoader(
                    cubit: verifyEmail,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          if (!key.currentState!.validate()) {
                            return;
                          }
                          if (widget.params.reason == OtpReason.email) {
                            verifyEmail.exec(code: otp);
                          }
                        },
                        child: Text(context.translation.continuE),
                      ),
                    ),
                  ),
                  16.height(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TimerDisableWidget(
                      controller: controller,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: OutlinedButton(
                          onPressed: () {
                            if (widget.params.reason == OtpReason.email) {
                              sendEmail.exec(email: widget.params.email);
                            }
                          },
                          child: Text(context.translation.resend),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
