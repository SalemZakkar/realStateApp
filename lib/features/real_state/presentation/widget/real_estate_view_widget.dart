import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:real_state/features/core/presentation/utils/ext/num_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/buttons/inkwell_without_feedback.dart';
import 'package:real_state/features/core/presentation/widget/images_widget.dart';
import 'package:real_state/features/core/presentation/widget/map_cluster_widget.dart';
import 'package:real_state/features/core/presentation/widget/map_widget.dart';
import 'package:real_state/features/core/presentation/widget/sheets/contact_us_sheet.dart';
import 'package:real_state/features/core/presentation/widget/text/header_text.dart';
import 'package:real_state/features/core/presentation/widget/text/icon_text.dart';
import 'package:real_state/features/core/presentation/widget/text/text_item_widget.dart';
import 'package:real_state/features/real_state/domain/entity/real_estate.dart';
import 'package:real_state/generated/generated_assets/assets.gen.dart';
import 'package:real_state/themes/app_theme.dart';

class RealEstateViewWidget extends StatefulWidget {
  final RealEstate realEstate;

  const RealEstateViewWidget({super.key, required this.realEstate});

  @override
  State<RealEstateViewWidget> createState() => _RealEstateViewWidgetState();
}

class _RealEstateViewWidgetState extends State<RealEstateViewWidget> {
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
                  child: ImagesWidget(
                    images: widget.realEstate.images,
                    height: 320,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    16.height(),
                    Row(
                      children: [
                        Expanded(
                          child: HeaderText(title: widget.realEstate.title),
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
                    16.height(),
                    IconText(
                      icon: Assets.icons.dollar,

                      // textStyle: Theme.of(context).textTheme.bodyMedium,
                      text: widget.realEstate.price.formatPrice(context),
                    ),
                    16.height(),
                    IconText(
                      icon: Assets.icons.maps,

                      // textStyle: Theme.of(context).textTheme.bodyMedium,
                      text: widget.realEstate.neighborhood,
                    ),
                    if (widget.realEstate.description != null) ...[
                      16.height(),
                      Text(
                        widget.realEstate.description!,
                        // style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                    16.height(),
                    HeaderText(title: context.translation.specifications),
                    16.height(),
                    TextItemWidget(
                      title: context.translation.city,
                      description: widget.realEstate.city.name,
                    ),
                    8.height(),
                    TextItemWidget(
                      title: context.translation.category,
                      description: context.translation.categoryE(
                        widget.realEstate.category.name,
                      ),
                    ),

                    8.height(),
                    TextItemWidget(
                      title: context.translation.propertyDeed,
                      description: context.translation.propertyDeedE(
                        widget.realEstate.propertyDeedType.name,
                      ),
                    ),

                    8.height(),
                    TextItemWidget(
                      title: context.translation.rooms,
                      description: widget.realEstate.room.toString(),
                    ),

                    8.height(),
                    if (widget.realEstate.address != null) ...[
                      8.height(),
                      TextItemWidget(
                        title: context.translation.address,
                        description: widget.realEstate.address!,
                      ),
                    ],
                    TextItemWidget(
                      title: context.translation.rooms,
                      description: widget.realEstate.room.toString(),
                    ),

                    8.height(),
                    TextItemWidget(
                      title: context.translation.bathrooms,
                      description: widget.realEstate.bathrooms.toString(),
                    ),
                    8.height(),
                    TextItemWidget(
                      title: context.translation.area,
                      description:
                          "${widget.realEstate.size} ${context.translation.m2}",
                    ),
                    8.height(),
                    TextItemWidget(
                      title: context.translation.propertyType,
                      description: context.translation.propertyTypeE(
                        widget.realEstate.propertyType.name,
                      ),
                    ),
                    if (widget.realEstate.propertyAge != null) ...[
                      8.height(),
                      TextItemWidget(
                        title: context.translation.age,
                        description:
                            "${widget.realEstate.propertyAge} ${context.translation.year}",
                      ),
                    ],
                    16.height(),
                    HeaderText(title: context.translation.location),
                    16.height(),
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
                      latLng: widget.realEstate.location.latLng,
                    ),
                    40.height(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => ContactUsSheet(),
              );
            },
            child: Text(context.translation.contactUs),
          ),
        ),
      ),
    );
  }
}
