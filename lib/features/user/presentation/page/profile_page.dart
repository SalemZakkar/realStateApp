import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/page/legal_page.dart';
import 'package:real_state/features/core/presentation/utils/ext/dynamic_svg_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/string.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/bloc_consumers/user_builder.dart';
import 'package:real_state/features/core/presentation/widget/button/log_out_button.dart';
import 'package:real_state/features/core/presentation/widget/log_in_widget.dart';
import 'package:real_state/features/user/domain/params/user_update_params.dart';
import 'package:real_state/features/user/presentation/cubit/user_update_cubit.dart';
import 'package:real_state/features/user/presentation/widget/user_edit_dialog.dart';
import 'package:real_state/generated/generated_assets/assets.gen.dart';
import 'package:real_state/injection.dart';

class ProfilePage extends StatefulWidget {
  static const String path = "/profilePage";

  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final cubit = getIt<UserUpdateCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.translation.profile),
        centerTitle: true,
      ),
      body: LogInWidget(
        child: Container(
          constraints: const BoxConstraints.expand(),
          child: ScreenLoader(
            cubit: cubit,
            withSuccess: false,
            useRoot: true,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              constraints: BoxConstraints.expand(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    UserBuilder(
                      builder: (context, user) {
                        return Column(
                          children: [
                            ImageWidget(
                              placeHolder: Assets.images.profilePlaceholder
                                  .image(),
                              width: MediaQuery.of(context).size.width,
                              height: 250,
                              onDelete: user.image == null
                                  ? null
                                  : () {
                                      cubit.change(
                                        UserUpdateParams(deleteImage: true),
                                      );
                                    },
                              onChanged: (v) {
                                cubit.change(UserUpdateParams(image: v));
                              },
                              url: user.image?.getUrl,
                              borderRadius: BorderRadius.circular(12),
                              editable: true,
                              pickImageConfig: PickImageConfig(
                                rootNavigator: true,
                                withCrop: false,
                              ),
                            ),
                            16.height(),
                            CustomCardWidget(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    InkWellWithoutFeedback(
                                      child: TileButton(
                                        padding: EdgeInsets.zero,
                                        leading: Assets.icons.user
                                            .dynamicSVGColor(
                                              context,
                                              color: Theme.of(
                                                context,
                                              ).primaryColor,
                                              width: 24,
                                              height: 24,
                                            ),
                                        trailing: Assets.icons.edit
                                            .dynamicSVGColor(
                                              context,
                                              color: Theme.of(
                                                context,
                                              ).primaryColor,
                                            ),
                                        title: user.name ?? '',
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
                                    16.height(),
                                    TileButton(
                                      padding: EdgeInsets.zero,
                                      leading: Assets.icons.phoneCall
                                          .dynamicSVGColor(
                                            context,
                                            color: Theme.of(
                                              context,
                                            ).primaryColor,
                                            width: 24,
                                            height: 24,
                                          ),
                                      trailing: const SizedBox(),
                                      title: user.phoneNumber ?? '',
                                      textAlign: TextAlign.end,
                                      textDirection: TextDirection.ltr,
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            16.height(),
                            CustomCardWidget(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    InkWellWithoutFeedback(
                                      onTap: () {},
                                      child: TileButton(
                                        padding: EdgeInsets.zero,
                                        leading: Assets.icons.building
                                            .dynamicSVGColor(
                                              context,
                                              color: Theme.of(
                                                context,
                                              ).primaryColor,
                                            ),
                                        title: context.translation.myProperties,
                                        trailing: Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                    32.height(),
                                    InkWellWithoutFeedback(
                                      onTap: () {
                                        // context.push(
                                        //   RealEStateListPage.extPath,
                                        //   extra: RealEstateListPageParams.saved(
                                        //     context,
                                        //   ),
                                        // );
                                      },
                                      child: TileButton(
                                        padding: EdgeInsets.zero,
                                        leading: Assets.icons.bookmark
                                            .dynamicSVGColor(
                                              context,
                                              color: Theme.of(
                                                context,
                                              ).primaryColor,
                                            ),
                                        title:
                                            context.translation.savedProperties,
                                        trailing: Icon(
                                          Icons.arrow_forward_ios_outlined,

                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                    32.height(),
                                    InkWellWithoutFeedback(
                                      onTap: () {
                                        // context.push(
                                        //   RealEStateListPage.extPath,
                                        //   extra: RealEstateListPageParams.saved(
                                        //     context,
                                        //   ),
                                        // );
                                      },
                                      child: TileButton(
                                        padding: EdgeInsets.zero,
                                        leading: Icon(
                                          Icons.add,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        title:
                                            context.translation.addNewProperty,
                                        trailing: Icon(
                                          Icons.arrow_forward_ios_outlined,

                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            16.height(),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Column(
                                children: [
                                  InkWellWithoutFeedback(
                                    onTap: () {
                                      context.push(LegalPage.path, extra: 0);
                                    },
                                    child: TileButton(
                                      title: context.translation.privacyPolicy,
                                    ),
                                  ),
                                  InkWellWithoutFeedback(
                                    onTap: () {
                                      context.push(LegalPage.path, extra: 1);
                                    },
                                    child: TileButton(
                                      title: context
                                          .translation
                                          .termsAndConditions,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            16.height(),
                            LogOutButton(),
                          ],
                        );
                      },
                    ),

                    128.height(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
