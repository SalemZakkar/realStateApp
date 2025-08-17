import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:real_state/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:real_state/features/auth/presentation/page/auth_login_page.dart';
import 'package:real_state/features/core/presentation/utils/ext/format_to_normal.dart';
import 'package:real_state/features/core/presentation/utils/ext/num_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/buttons/inkwell_without_feedback.dart';
import 'package:real_state/features/core/presentation/widget/image_widget.dart';
import 'package:real_state/features/core/presentation/widget/sheets/regular_bottom_sheet_layout.dart';
import 'package:real_state/features/real_state/domain/entity/real_estate.dart';
import 'package:real_state/features/real_state/domain/repository/real_estate_repository.dart';
import 'package:real_state/features/real_state/presentation/cubit/real_estate_get_list_cubit.dart';
import 'package:real_state/features/real_state/presentation/page/real_estate_details_page.dart';

import '../../../../generated/generated_assets/assets.gen.dart';
import '../../../../injection.dart';
import '../../../core/presentation/widget/text/icon_text.dart';

class RealStateCard extends StatefulWidget {
  final RealEstate realEstate;

  const RealStateCard({super.key, required this.realEstate});

  @override
  State<RealStateCard> createState() => _RealStateCardState();
}

class _RealStateCardState extends State<RealStateCard> {
  @override
  Widget build(BuildContext context) {
    double h = 100;
    return InkWellWithoutFeedback(
      onTap: () {
        context.pushNamed(RealEstateDetailsPage.path, extra: widget.realEstate);
      },
      child: Container(
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
              url: widget.realEstate.images.first,
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
                      text: widget.realEstate.title,
                    ),
                    6.height(),
                    IconText(
                      icon: Assets.icons.maps,
                      text: widget.realEstate.neighborhood,
                    ),
                    6.height(),
                    IconText(
                      icon: Assets.icons.dollar,
                      text: widget.realEstate.price
                          .toStringAsFixed(0)
                          .formatNum(),
                    ),
                  ],
                ),
              ),
            ),
            8.width(),
            IconButton(
              onPressed: () {
                if (getIt<AuthCubit>().state.authenticated) {
                  widget.realEstate.isFavourite =
                      !widget.realEstate.isFavourite;
                  if (widget.realEstate.isFavourite) {
                    getIt<RealEstateRepository>().save(
                      id: widget.realEstate.id,
                    );
                  } else {
                    getIt<RealEstateGetListCubit>().removeFavourite(
                      widget.realEstate.id,
                    );
                    getIt<RealEstateRepository>().unSave(
                      id: widget.realEstate.id,
                    );
                  }
                  setState(() {});
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
              icon: Icon(
                widget.realEstate.isFavourite
                    ? Icons.bookmark
                    : Icons.bookmark_border,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
