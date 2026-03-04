import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/utils/ext/dynamic_svg_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/num.dart';
import 'package:real_state/features/core/presentation/utils/ext/string.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/properties/domain/entity/property.dart';
import 'package:real_state/features/properties/presentation/page/properties_details_page.dart';
import 'package:real_state/features/properties/presentation/widget/property_category_type_widget.dart';
import 'package:real_state/generated/generated_assets/assets.gen.dart';

class PropertyGridCardWidget extends StatefulWidget {
  final Property property;

  const PropertyGridCardWidget({super.key, required this.property});

  @override
  State<PropertyGridCardWidget> createState() => _PropertyGridCardWidgetState();
}

class _PropertyGridCardWidgetState extends State<PropertyGridCardWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWellWithoutFeedback(
      onTap: (){
        context.push(PropertyDetailsPage.path , extra: widget.property.id);
      },
      child: Column(
        spacing: 8,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: Stack(
              children: [
                ImageWidget(
                  url: widget.property.cover?.getUrl,
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  borderRadius: BorderRadius.circular(6),
                ),
                PositionedDirectional(
                  top: 4,
                  start: 4,
                  child: CustomCardWidget(
                    borderRadius: BorderRadius.circular(6),
                    padding: EdgeInsets.symmetric(),
                    child: PropertyCategoryTypeWidget(property: widget.property),
                  ),
                ),
              ],
            ),
          ),
          // 8.height(),
          Row(
            children: [
              Expanded(
                child: IconText(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  icon: Assets.icons.size.dynamicSVGColor(
                    context,
                    color: Theme.of(context).primaryColor,
                  ),
                  text: "${widget.property.size} ${context.translation.m2}",
                ),
              ),
            ],
          ),
          IconText(
            crossAxisAlignment: CrossAxisAlignment.start,
            icon: Assets.icons.maps.dynamicSVGColor(
              context,
              color: Theme.of(context).primaryColor,
            ),
            text: widget.property.city.name,
          ),
          IconText(
            crossAxisAlignment: CrossAxisAlignment.start,
            icon: Assets.icons.dollar.dynamicSVGColor(
              context,

              color: Theme.of(context).primaryColor,
            ),
            text: widget.property.price.formatPrice(context),
          ),
        ],
      ),
    );
  }
}
