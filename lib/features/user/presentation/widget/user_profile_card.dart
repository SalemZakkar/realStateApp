import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/utils/ext/string.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/button/log_out_button.dart';
import 'package:real_state/features/user/domain/entity/user.dart';
import 'package:real_state/features/user/domain/params/user_update_params.dart';
import 'package:real_state/features/user/presentation/cubit/user_update_cubit.dart';
import 'package:real_state/features/user/presentation/widget/user_edit_dialog.dart';
import 'package:real_state/injection.dart';
import 'package:real_state/themes/app_theme.dart';

class UserProfileCard extends StatefulWidget {
  final User user;

  const UserProfileCard({super.key, required this.user});

  @override
  State<UserProfileCard> createState() => _UserProfileCardState();
}

class _UserProfileCardState extends State<UserProfileCard> {
  var cubit = getIt<UserUpdateCubit>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomCardWidget(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScreenLoader(
                  cubit: cubit,
                  child: ImageWidget(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    onDelete: widget.user.image != null
                        ? () {
                            cubit.change(UserUpdateParams(deleteImage: true));
                          }
                        : null,
                    borderRadius: BorderRadius.circular(6),
                    url: widget.user.image?.getUrl,
                    editable: true,
                    onChanged: (v) {
                      cubit.change(UserUpdateParams(image: v));
                    },
                    pickImageConfig: PickImageConfig(
                      withCrop: false,
                      rootNavigator: true,
                      quality: 30,
                    ),
                  ),
                ),
                8.height(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: HeaderText(title: (widget.user.name ?? '')),
                    ),
                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => UserEditDialog(
                            user: widget.user,
                            onChanged: (v) {
                              cubit.change(v);
                            },
                          ),
                        );
                      },
                      child: Text(context.translation.edit),
                    ),
                  ],
                ),
                Text(
                  widget.user.phoneNumber ?? '',
                  textDirection: TextDirection.ltr,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.appColorSchema.textColors.primaryText,
                  ),
                ),
              ],
            ),
          ),
        ),
        16.height(),
        LogOutButton(),
      ],
    );
  }
}
