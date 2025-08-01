import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:real_state/features/core/domain/enum/contact_type.dart';
import 'package:real_state/features/core/presentation/cubit/contact_cubit.dart';
import 'package:real_state/features/core/presentation/utils/ext/dynamic_svg_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/num_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/bloc_consumers/consumer_widget.dart';
import 'package:real_state/features/core/presentation/widget/bloc_consumers/screen_loader.dart';
import 'package:real_state/features/core/presentation/widget/bloc_consumers/user_builder.dart';
import 'package:real_state/features/core/presentation/widget/contact_icon.dart';
import 'package:real_state/features/user/presentation/cubit/user_update_cubit.dart';
import 'package:real_state/themes/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

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
                                      child: _Button(
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
                                      child: _Button(
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
                                      child: _Button(
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
                                  InkWellWithoutFeedback(
                                    onTap: () {
                                      if (e.type == ContactType.whatsapp) {
                                        if (Platform.isAndroid) {
                                          launchUrl(
                                            Uri.parse(
                                              "https://wa.me/${e.value}/?text=hello",
                                            ),
                                          );
                                        } else {
                                          launchUrl(
                                            Uri.parse(
                                              "https://api.whatsapp.com/send?phone=${e.type}=hello",
                                            ),
                                          );
                                        }
                                        return;
                                      }
                                      if (e.type == ContactType.call) {
                                        launchUrl(
                                          Uri.parse("tel://${e.value}"),
                                        );
                                        return;
                                      }
                                      if (e.type == ContactType.telegram) {
                                        launchUrl(
                                          Uri.parse("https://t.me/${e.value}"),
                                        );
                                        return;
                                      }

                                      if (e.type == ContactType.facebook ||
                                          e.type == ContactType.instagram) {
                                        launchUrl(Uri.parse(e.value));
                                        return;
                                      }
                                    },
                                    child: _Button(
                                      image: ContactIcon(contactType: e.type),
                                      title: e.title ?? e.value,
                                      isSend: true,
                                    ),
                                  ),
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

class _Button extends StatelessWidget {
  final dynamic image;
  final String title;
  final bool isSend;

  const _Button({
    required this.image,
    required this.title,
    this.isSend = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (image is SvgGenImage) ...[
          (image as SvgGenImage).dynamicSVGColor(
            context,
            color: Theme.of(context).primaryColor,
            width: 24,
            height: 24,
          ),
        ],
        if (image is Widget) image,
        8.width(),
        Expanded(
          child: Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
        ),
        (isSend ? Assets.icons.send : Assets.icons.edit).dynamicSVGColor(
          context,
          color: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}
