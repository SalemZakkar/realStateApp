import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/utils/ext/dynamic_svg_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/num.dart';
import 'package:real_state/features/core/presentation/utils/ext/string.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/contact_us_phone_buttons.dart';
import 'package:real_state/features/properties/domain/entity/property.dart';
import 'package:real_state/generated/generated_assets/assets.gen.dart';
import 'package:real_state/themes/app_theme.dart';

class PropertyViewWidget extends StatefulWidget {
  final Property realEstate;

  const PropertyViewWidget({super.key, required this.realEstate});

  @override
  State<PropertyViewWidget> createState() => _PropertyViewWidgetState();
}

class _PropertyViewWidgetState extends State<PropertyViewWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              stretch: true,
              // backgroundColor: Theme.of(context).cardColor,
              pinned: true,
              leadingWidth: 60,
              leading: InkWellWithoutFeedback(
                onTap: () {
                  context.pop();
                },
                child: Container(
                  margin: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: context.appColorSchema.shapeColors.cardColor,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(end: 3),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: context.appColorSchema.shapeColors.iconColor,
                    ),
                  ),
                ),
              ),
              // backgroundColor: Colors.red,
              flexibleSpace: FlexibleSpaceBar(
                title: null,
                titlePadding: EdgeInsets.zero,

                stretchModes: [StretchMode.blurBackground],
                background: SizedBox(
                  height: 320,
                  // color: Colors.red,
                  width: MediaQuery.of(context).size.width,
                  child: ImageStepIndicator(
                    height: 320,
                    links: widget.realEstate.images
                        .map((e) => e.getUrl!)
                        .toList(),
                  ),
                ),
              ),

              // toolbarHeight: 200,
              // collapsedHeight: 200,
              expandedHeight: 320,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: HeaderText(
                            title: widget.realEstate.price.formatPrice(context),
                            textStyle: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                                  color: Theme.of(context).primaryColor,
                                ),
                          ),
                        ),
                        if (widget.realEstate.isFeature) ...[
                          8.width(),
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: context.appColorSchema.statusColors.pending
                                  .withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              context.translation.featured,
                              style: TextStyle(
                                color:
                                    context.appColorSchema.statusColors.pending,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    IconText(
                      icon: Assets.icons.maps.dynamicSVGColor(context),
                      text: widget.realEstate.city.name,
                    ),
                    CustomCardWidget(
                      child: Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 16,
                        children: [
                          ImageWidget(
                            url: widget.realEstate.owner.image?.getUrl,
                            placeHolder: Assets.images.profilePlaceholder
                                .image(),
                            radius: 60,
                            shape: BoxShape.circle,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text((widget.realEstate.owner.name ?? '')),
                                8.height(),
                                Text(
                                  widget.realEstate.owner.phoneNumber ?? '',
                                  textAlign: TextAlign.end,
                                  textDirection: TextDirection.ltr,
                                ),
                              ],
                            ),
                          ),
                          ContactUsPhoneButtons(
                            phone: widget.realEstate.owner.phoneNumber ?? '',
                          ),
                        ],
                      ),
                    ),
                    CustomCardWidget(
                      child: Column(
                        spacing: 8,
                        children: [
                          if (widget.realEstate.neighborhood != null) ...[
                            TextItemWidget(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              title: context.translation.neighborhood,
                              titleStyle: Theme.of(context).textTheme.bodyLarge,
                              description: widget.realEstate.neighborhood ?? '',
                            ),
                          ],
                          TextItemWidget(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            title: context.translation.category,
                            titleStyle: Theme.of(context).textTheme.bodyLarge,
                            description: context.translation.categoryE(
                              widget.realEstate.category.name,
                            ),
                          ),
                          TextItemWidget(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            title: context.translation.propertyDeed,
                            titleStyle: Theme.of(context).textTheme.bodyLarge,
                            description: context.translation.propertyDeedE(
                              widget.realEstate.propertyDeedType.name,
                            ),
                          ),
                          TextItemWidget(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            title: context.translation.rooms,
                            titleStyle: Theme.of(context).textTheme.bodyLarge,
                            description: widget.realEstate.room.toString(),
                          ),
                          if (widget.realEstate.address != null) ...[
                            TextItemWidget(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              title: context.translation.address,
                              titleStyle: Theme.of(context).textTheme.bodyLarge,
                              description: widget.realEstate.address!,
                            ),
                          ],
                          TextItemWidget(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            title: context.translation.floor,
                            titleStyle: Theme.of(context).textTheme.bodyLarge,
                            description: widget.realEstate.floor.toString(),
                          ),

                          TextItemWidget(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            title: context.translation.bathrooms,
                            titleStyle: Theme.of(context).textTheme.bodyLarge,
                            description: widget.realEstate.bathrooms.toString(),
                          ),
                          TextItemWidget(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            title: context.translation.area,
                            titleStyle: Theme.of(context).textTheme.bodyLarge,
                            description:
                                "${widget.realEstate.size} ${context.translation.m2}",
                          ),
                          TextItemWidget(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            title: context.translation.propertyType,
                            titleStyle: Theme.of(context).textTheme.bodyLarge,
                            description: context.translation.propertyTypeE(
                              widget.realEstate.propertyType.name,
                            ),
                          ),
                          if (widget.realEstate.propertyAge != null) ...[
                            TextItemWidget(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              title: context.translation.age,
                              titleStyle: Theme.of(context).textTheme.bodyLarge,
                              description:
                                  "${widget.realEstate.propertyAge} ${context.translation.year}",
                            ),
                          ],
                        ],
                      ),
                    ),
                    // HeaderText(title: context.translation.location),
                    MapWidget(
                      ignore: true,
                      withExpand: true,
                      icon: MarkerData.fromWidget(
                        child: Assets.icons.mapMarker.svg(
                          width: 40,
                          height: 40,
                        ),
                        size: Size(40, 40),
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      zoomControls: false,
                      latLng: widget.realEstate.coordinates,
                    ),
                    120.height(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
