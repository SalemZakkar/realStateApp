import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:real_state/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:real_state/features/auth/presentation/page/auth_login_page.dart';
import 'package:real_state/features/core/presentation/utils/ext/num_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/image_widget.dart';
import 'package:real_state/features/core/presentation/widget/sheets/regular_bottom_sheet_layout.dart';
import 'package:real_state/themes/app_theme.dart';

import '../../../../generated/generated_assets/assets.gen.dart';
import '../../../../injection.dart';
import '../../../core/presentation/widget/text/icon_text.dart';

class RealStateCard extends StatefulWidget {
  const RealStateCard({super.key});

  @override
  State<RealStateCard> createState() => _RealStateCardState();
}

class _RealStateCardState extends State<RealStateCard> {
  @override
  Widget build(BuildContext context) {
    double h = 100;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(6),
      ),
      padding: EdgeInsets.all(8),
      constraints: BoxConstraints(minHeight: h),
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageWidget(
            borderRadius: BorderRadius.circular(4),
            width: h,
            height: h,
            url:
                "https://modernvillasco.com/wp-content/uploads/2024/05/Villa-construction-17.jpg",
          ),
          8.width(),
          Expanded(
            child: Container(
              constraints: BoxConstraints(minHeight: h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconText(
                    icon: Assets.icons.info,
                    size: 18,
                    text: 'Title',
                    textStyle: TextStyle(
                      color: context.appColorSchema.textColors.primaryText,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  6.height(),
                  IconText(icon: Assets.icons.maps, text: 'hama , albaath'),
                  6.height(),
                  IconText(icon: Assets.icons.dollar, text: '123,123'),
                ],
              ),
            ),
          ),
          8.width(),
          IconButton(
            onPressed: () {
              if (getIt<AuthCubit>().state.authenticated) {
              } else {
                showModalBottomSheet(
                  context: context,
                  useRootNavigator: true,
                  builder: (context) {
                    return RegularBottomSheetLayout(
                      body: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            context.translation.toSaveYouMustLogin,
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          8.height(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              onPressed: () {
                                context.pop();
                                context.pushNamed(AuthLoginPage.path);
                              },
                              child: Text(context.translation.logIn),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            },
            icon: Icon(Icons.bookmark_border),
          ),
        ],
      ),
    );
  }
}
