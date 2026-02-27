import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:real_state/features/auth/presentation/cubits/auth_login_otp.dart';
import 'package:real_state/features/auth/presentation/cubits/auth_otp_cubit.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/injection.dart';

class AuthOtpPage extends StatefulWidget {
  static const String path = '/auth/otp';
  final String phone;

  const AuthOtpPage({super.key, required this.phone});

  @override
  State<AuthOtpPage> createState() => _AuthOtpPageState();
}

class _AuthOtpPageState extends State<AuthOtpPage> {
  final key = GlobalKey<FormState>();
  var cubit = getIt<AuthOtpCubit>();
  var auth = getIt<AuthLoginCubit>();
  var controller = TimerDisableWidgetController();
  String code = '';
  String vid = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((e) {
      cubit.request(phone: widget.phone);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.translation.verification)),
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
                  context.translation.sendTheCodeWeHaveSent,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                16.height(),
                PinEntryTextField(
                  fields: 6,
                  onSubmit: (v) {
                    code = v;
                    auth.login(vid: vid, code: code);
                  },
                ),
                16.height(),
                ScreenLoader(
                  cubit: auth,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        if (!key.currentState!.validate()) {
                          return;
                        }
                        auth.login(vid: vid, code: code);
                      },
                      child: Text(context.translation.logIn),
                    ),
                  ),
                ),
                16.height(),
                ScreenLoader(
                  cubit: cubit,
                  onSuccess: (v) {
                    vid = v.vid;
                    controller.toggle(
                      DateTime.now().difference(v.nextDate).inSeconds.abs(),
                    );
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TimerDisableWidget(
                      controller: controller,
                      child: TextButton(
                        onPressed: () {
                          cubit.request(phone: widget.phone);
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
    );
  }
}
