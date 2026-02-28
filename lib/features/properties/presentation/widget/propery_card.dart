import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/utils/ext/dynamic_svg_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/num.dart';
import 'package:real_state/features/core/presentation/utils/ext/string.dart';
import 'package:real_state/features/properties/domain/entity/property.dart';
import 'package:real_state/features/properties/presentation/page/properties_details_page.dart';
import '../../../../generated/generated_assets/assets.gen.dart';

class PropertyCard extends StatefulWidget {
  final Property realEstate;

  const PropertyCard({super.key, required this.realEstate});

  @override
  State<PropertyCard> createState() => _PropertyCardState();
}

class _PropertyCardState extends State<PropertyCard> {
  @override
  Widget build(BuildContext context) {
    double h = 120;
    return InkWellWithoutFeedback(
      onTap: () {
        context.pushNamed(
          PropertyDetailsPage.path,
          extra: widget.realEstate.id,
        );
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
              placeHolder: Align(
                alignment: AlignmentGeometry.center,
                child: Assets.icons.building.dynamicSVGColor(
                  context,
                  width: 32,
                  height: 32,
                ),
              ),
              url: widget.realEstate.cover?.getUrl,
            ),
            8.width(),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      constraints: BoxConstraints(minHeight: h),
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconText(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            icon: Icon(Icons.tag),
                            text: widget.realEstate.refNumber,
                          ),
                          16.height(),
                          IconText(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            icon: Assets.icons.maps.dynamicSVGColor(context),
                            text: widget.realEstate.city.name,
                          ),
                          16.height(),
                          IconText(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            icon: Assets.icons.dollar.dynamicSVGColor(context),
                            text: widget.realEstate.price.formatPrice(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
