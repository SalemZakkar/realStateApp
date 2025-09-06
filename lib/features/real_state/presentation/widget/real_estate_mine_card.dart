import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:real_state/features/core/presentation/utils/ext/dynamic_svg_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/num_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/string.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/buttons/inkwell_without_feedback.dart';
import 'package:real_state/features/core/presentation/widget/image_widget.dart';
import 'package:real_state/features/core/presentation/widget/text/icon_text.dart';
import 'package:real_state/features/real_state/domain/entity/real_estate.dart';
import 'package:real_state/features/real_state/domain/enum/real_estate_post_status.dart';
import 'package:real_state/features/real_state/presentation/page/real_estate_details_page.dart';
import 'package:real_state/features/real_state/presentation/widget/real_estate_status_widget.dart';
import 'package:real_state/generated/generated_assets/assets.gen.dart';
import 'package:real_state/themes/app_theme.dart';

class RealEstateMineCard extends StatefulWidget {
  final RealEstate realEstate;

  const RealEstateMineCard({super.key, required this.realEstate});

  @override
  State<RealEstateMineCard> createState() => _RealEstateMineCardState();
}

class _RealEstateMineCardState extends State<RealEstateMineCard> {
  @override
  Widget build(BuildContext context) {
    double h = 100;
    return InkWellWithoutFeedback(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(6),
        ),
        padding: EdgeInsets.all(8),
        constraints: BoxConstraints(minHeight: h),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWellWithoutFeedback(
              onTap: () {
                context.push(
                  RealEstateDetailsPage.path,
                  extra: widget.realEstate,
                );
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 220,
                child: Stack(
                  children: [
                    ImageWidget(
                      borderRadius: BorderRadius.circular(4),
                      width: MediaQuery.of(context).size.width,
                      height: 220,
                      placeHolder: Align(
                        alignment: AlignmentGeometry.center,
                        child: Assets.icons.building.dynamicSVGColor(
                          context,
                          width: 32,
                          height: 32,
                        ),
                      ),
                      color: Colors.black.withValues(alpha: 0.55),
                      blendMode: BlendMode.darken,
                      url: widget.realEstate.images.firstOrNull?.getUrl,
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: RealEstateStatusWidget(
                        estate: widget.realEstate,
                        withOpacity: false,
                      ),
                    ),
                    Positioned(
                      left: 8,
                      right: 8,
                      bottom: 8,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        alignment: AlignmentDirectional.topStart,
                        width: MediaQuery.of(context).size.width,
                        // color: Colors.red,
                        child: Text(
                          widget.realEstate.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color:
                              widget.realEstate.postStatus ==
                                  RealEstatePostStatus.pending
                              ? context.appColorSchema.statusColors.pending
                              : widget.realEstate.postStatus ==
                                    RealEstatePostStatus.approved
                              ? context.appColorSchema.statusColors.success
                              : context.appColorSchema.statusColors.fail,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          context.translation.propertyPostStatusE(
                            widget.realEstate.postStatus.name,
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            8.height(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconText(
                  icon: Assets.icons.maps,
                  size: 22,
                  text: widget.realEstate.neighborhood,
                  textStyle: TextStyle(fontSize: 20),
                ),
                8.height(),
                IconText(
                  icon: Assets.icons.dollar,
                  size: 22,
                  text: widget.realEstate.price.formatPrice(context),
                  textStyle: TextStyle(fontSize: 20),
                ),

                6.height(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
