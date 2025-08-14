import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:real_state/features/core/domain/enum/contact_type.dart';
import 'package:real_state/features/core/presentation/cubit/contact_cubit.dart';
import 'package:real_state/features/core/presentation/utils/ext/num_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/bloc_consumers/consumer_widget.dart';
import 'package:real_state/features/core/presentation/widget/bloc_consumers/screen_loader.dart';
import 'package:real_state/features/core/presentation/widget/bloc_consumers/user_builder.dart';
import 'package:real_state/features/core/presentation/widget/buttons/tile_button.dart';
import 'package:real_state/features/core/presentation/widget/contact_us_card.dart';
import 'package:real_state/features/user/presentation/cubit/user_update_cubit.dart';
import 'package:real_state/themes/app_theme.dart';

import '../../../../generated/generated_assets/assets.gen.dart';
import '../../../../injection.dart';
import '../../../auth/domain/repository/auth_repository.dart';
import '../../../user/domain/params/user_update_params.dart';
import '../../../user/presentation/page/user_change_password_page.dart';
import '../../../user/presentation/widget/user_edit_dialog.dart';
import '../widget/buttons/inkwell_without_feedback.dart';
import '../widget/custom_card_widget.dart';
import '../widget/dialogs/dialog_util.dart';
import '../widget/log_in_widget.dart';
import '../widget/text/header_text.dart';

class SettingsPage extends StatefulWidget {
  static String path = '/settings_page';

  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final cubit = getIt<UserUpdateCubit>();
  final contact = getIt<ContactCubit>();

  @override
  void initState() {
    super.initState();
    contact.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ConsumerWidget(
        autoDispose: false,
        cubit: contact,
        childBuilder: (context, c) {
          return ScreenLoader(
            cubit: cubit,
            withSuccess: false,
            onSuccess: (v) {
              // context.pop();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              constraints: const BoxConstraints.expand(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    UserBuilder(
                      builder: (context, user) {
                        return Column(
                          children: [
                            HeaderText(title: context.translation.profile),
                            8.height(),
                            CustomCardWidget(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    InkWellWithoutFeedback(
                                      child: TileButton(
                                        image: Assets.icons.user,
                                        title: user.name,
                                      ),
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => UserEditDialog(
                                            user: user,
                                            onChanged:
                                                (UserUpdateParams value) {
                                                  cubit.change(value);
                                                },
                                          ),
                                        );
                                      },
                                    ),
                                    32.height(),
                                    InkWellWithoutFeedback(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => UserEditDialog(
                                            user: user,
                                            onChanged:
                                                (UserUpdateParams value) {
                                                  cubit.change(value);
                                                },
                                          ),
                                        );
                                      },
                                      child: TileButton(
                                        image: Icon(
                                          Icons.phone_android,
                                          color: Theme.of(context).primaryColor,
                                          size: 24,
                                        ),
                                        title:
                                            user.phoneNumber.phoneNumber ?? '',
                                      ),
                                    ),
                                    32.height(),
                                    InkWellWithoutFeedback(
                                      onTap: () {
                                        context.pushNamed(
                                          UserChangePasswordPage.path,
                                        );
                                      },
                                      child: TileButton(
                                        image: Assets.icons.password,
                                        title: context.translation.password,
                                      ),
                                    ),
                                    // ListTile(

                                    //   title: Text(context.translation.phone),
                                    // ),
                                    // ListTile(
                                    //   leading: Icon(
                                    //     Icons.phone_android,
                                    //     color: Theme.of(context).primaryColor,
                                    //   ),
                                    //   title: Text(context.translation.phone),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    16.height(),
                    HeaderText(title: context.translation.contactUs),
                    8.height(),
                    CustomCardWidget(
                      padding: EdgeInsets.only(
                        top: 16,
                        bottom: 0,
                        left: 16,
                        right: 16,
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            for (var type in ContactType.values) ...[
                              for (var e in c) ...[
                                if (e.type == type) ...[
                                  ContactUsCard(contactItem: e),
                                  16.height(),
                                ],
                              ],
                            ],

                            // ListTile(

                            //   title: Text(context.translation.phone),
                            // ),
                            // ListTile(
                            //   leading: Icon(
                            //     Icons.phone_android,
                            //     color: Theme.of(context).primaryColor,
                            //   ),
                            //   title: Text(context.translation.phone),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    16.height(),
                    LogInWidget(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                context.appColorSchema.statusColors.fail,
                          ),
                          onPressed: () {
                            DialogUtil(
                              context: context,
                              onDone: () {
                                getIt<AuthRepository>().logout();
                              },
                            ).showConfirmDialog(
                              message: context.translation.logoutMessage,
                            );
                          },
                          child: Text(context.translation.logOut),
                        ),
                      ),
                    ),
                    100.height(),
                  ],
                ),
              ),
            ),
          );
        },
        onRetry: () {
          contact.start();
        },
      ),
    );
  }
}
