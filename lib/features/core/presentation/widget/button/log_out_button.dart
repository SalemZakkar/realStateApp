import 'package:flutter/material.dart';
import 'package:real_state/features/auth/domain/repository/auth_repository.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/dialogs/dialog_util.dart';
import 'package:real_state/injection.dart';
import 'package:real_state/themes/app_theme.dart';

class LogOutButton extends StatefulWidget {
  const LogOutButton({super.key});

  @override
  State<LogOutButton> createState() => _LogOutButtonState();
}

class _LogOutButtonState extends State<LogOutButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: () {
          DialogUtil(context: context)
              .showConfirmDialog(
                title: context.translation.confirmation,
                message: context.translation.areUSureYouWillLogout,
              )
              .then((e) {
                if (e) {
                  getIt<AuthRepository>().logout();
                }
              });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: context.appColorSchema.statusColors.fail,
        ),
        child: Text(context.translation.logOut),
      ),
    );
  }
}
