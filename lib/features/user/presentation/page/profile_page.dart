import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:real_state/features/auth/domain/repository/auth_repository.dart';
import 'package:real_state/features/core/presentation/utils/ext/dynamic_svg_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/num_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/bloc_consumers/screen_loader.dart';
import 'package:real_state/features/core/presentation/widget/bloc_consumers/user_builder.dart';
import 'package:real_state/features/core/presentation/widget/buttons/inkwell_without_feedback.dart';
import 'package:real_state/features/core/presentation/widget/buttons/tile_button.dart';
import 'package:real_state/features/core/presentation/widget/custom_card_widget.dart';
import 'package:real_state/features/core/presentation/widget/dialogs/dialog_util.dart';
import 'package:real_state/features/core/presentation/widget/log_in_widget.dart';
import 'package:real_state/features/real_state/domain/params/real_estate_get_params.dart';
import 'package:real_state/features/real_state/presentation/cubit/real_estate_get_list_cubit.dart';
import 'package:real_state/features/real_state/presentation/cubit/real_estate_get_mine_list_cubit.dart';
import 'package:real_state/features/real_state/presentation/page/real_estate_list_page.dart';
import 'package:real_state/features/real_state/presentation/widget/real_estate_list_widget.dart';
import 'package:real_state/features/user/domain/params/user_update_params.dart';
import 'package:real_state/features/user/presentation/cubit/user_update_cubit.dart';
import 'package:real_state/features/user/presentation/page/user_change_password_page.dart';
import 'package:real_state/features/user/presentation/widget/user_edit_dialog.dart';
import 'package:real_state/generated/generated_assets/assets.gen.dart';
import 'package:real_state/injection.dart';
import 'package:real_state/themes/app_theme.dart';

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
      appBar: AppBar(title: Text(context.translation.profile)),
      body: LogInWidget(
        child: Container(
          constraints: const BoxConstraints.expand(),

          child: ScreenLoader(
            cubit: cubit,
            withSuccess: false,

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
                            CustomCardWidget(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    InkWellWithoutFeedback(
                                      child: TileButton(
                                        image: Assets.icons.user
                                            .dynamicSVGColor(
                                              context,
                                              color: Theme.of(
                                                context,
                                              ).primaryColor,
                                              width: 24,
                                              height: 24,
                                            ),
                                        icon: Assets.icons.edit.dynamicSVGColor(
                                          context,
                                          color: Theme.of(context).primaryColor,
                                        ),
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
                                        direction: TextDirection.ltr,
                                        title: user.formatNumber,
                                        icon: Assets.icons.edit.dynamicSVGColor(
                                          context,
                                          color: Theme.of(context).primaryColor,
                                        ),
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
                                        image: Assets.icons.password
                                            .dynamicSVGColor(
                                              context,
                                              color: Theme.of(
                                                context,
                                              ).primaryColor,
                                              width: 24,
                                              height: 24,
                                            ),
                                        icon: Assets.icons.edit.dynamicSVGColor(
                                          context,
                                          color: Theme.of(context).primaryColor,
                                        ),

                                        title: context.translation.password,
                                      ),
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
                                      onTap: () {
                                        context.push(
                                          RealEStateListPage.extPath,
                                          extra: RealEstateListPageParams(
                                            title: context
                                                .translation
                                                .myProperties,
                                            params: RealEstateGetParams(
                                              skip: 0,
                                              limit: 10,
                                            ),
                                            autoDispose: false,
                                            withFilter: false,
                                            bloc:
                                                getIt<
                                                  RealEstateGetMineListCubit
                                                >(),
                                          ),
                                        );
                                      },
                                      child: TileButton(
                                        image: Assets.icons.building
                                            .dynamicSVGColor(
                                              context,
                                              color: Theme.of(
                                                context,
                                              ).primaryColor,
                                            ),
                                        title: context.translation.myProperties,
                                        icon: Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                    32.height(),
                                    InkWellWithoutFeedback(
                                      onTap: () {
                                        context.push(
                                          RealEStateListPage.extPath,
                                          extra: RealEstateListPageParams(
                                            title: context
                                                .translation
                                                .savedProperties,
                                            params: RealEstateGetParams(
                                              skip: 0,
                                              limit: 10,
                                              isFavourite: true,
                                            ),
                                            autoDispose: false,
                                            withFilter: false,
                                            bloc:
                                                getIt<RealEstateGetListCubit>(),
                                          ),
                                        );
                                      },
                                      child: TileButton(
                                        image: Assets.icons.bookmark
                                            .dynamicSVGColor(
                                              context,
                                              color: Theme.of(
                                                context,
                                              ).primaryColor,
                                            ),
                                        title:
                                            context.translation.savedProperties,
                                        icon: Icon(
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
                            SizedBox(
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
