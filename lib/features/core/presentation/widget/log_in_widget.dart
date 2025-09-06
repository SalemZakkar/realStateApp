import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:real_state/features/auth/presentation/page/auth_login_page.dart';
import 'package:real_state/features/core/presentation/utils/ext/num_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/bloc_consumers/user_builder.dart';

class LogInWidget extends StatefulWidget {
  final Widget child;

  const LogInWidget({super.key, required this.child});

  @override
  State<LogInWidget> createState() => _LogInWidgetState();
}

class _LogInWidgetState extends State<LogInWidget> {
  @override
  Widget build(BuildContext context) {
    return UserBuilder(
      builder: (context, state) {
        return widget.child;
      },
      unAuthWidget: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.translation.authPageRequiresLogin,
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
                32.height(),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      context.push(AuthLoginPage.path);
                    },
                    child: Text(context.translation.logIn),
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
