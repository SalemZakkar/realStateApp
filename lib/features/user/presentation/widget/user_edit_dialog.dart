import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/user/domain/entity/user.dart';
import 'package:real_state/features/user/domain/params/user_update_params.dart';
import 'package:real_state/themes/app_theme.dart';

class UserEditDialog extends StatefulWidget {
  final User user;
  final ValueChanged<UserUpdateParams> onChanged;

  const UserEditDialog({
    super.key,
    required this.user,
    required this.onChanged,
  });

  @override
  State<UserEditDialog> createState() => _UserEditDialogState();
}

class _UserEditDialogState extends State<UserEditDialog> {
  PhoneNumber phoneNumber = PhoneNumber();
  TextEditingController name = TextEditingController();
  final key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((e) {
      name.text = widget.user.name ?? '';
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.user.phoneNumber);
    return AlertDialog(
      backgroundColor: Theme.of(context).cardColor,
      insetPadding: EdgeInsets.symmetric(horizontal: 16),
      title: Row(
        children: [
          Expanded(child: Text(context.translation.edit)),
          CloseButton(),
        ],
      ),
      content: Form(
        key: key,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    hintText: context.translation.name,
                  ),
                  controller: name,
                  validator: RequiredValidator(
                    errorText: context.translation.fieldRequiredMessage,
                  ).call,
                ),
                // 16.height(),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            context.pop();
          },
          style: TextButton.styleFrom(
            foregroundColor: context.appColorSchema.statusColors.fail,
            overlayColor: context.appColorSchema.statusColors.fail,
          ),
          child: Text(context.translation.cancel),
        ),
        TextButton(
          onPressed: () {
            if (key.currentState!.validate()) {
              widget.onChanged(UserUpdateParams(name: name.text));
              context.pop();
            }
          },
          child: Text(context.translation.save),
        ),
      ],
    );
  }
}
