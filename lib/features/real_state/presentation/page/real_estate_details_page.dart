import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:real_state/features/core/presentation/utils/ext/num_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/buttons/inkwell_without_feedback.dart';
import 'package:real_state/features/core/presentation/widget/sheets/contact_us_sheet.dart';
import 'package:real_state/features/core/presentation/widget/text/header_text.dart';
import 'package:real_state/features/core/presentation/widget/text/icon_text.dart';
import 'package:real_state/features/core/presentation/widget/text/text_item_widget.dart';
import 'package:real_state/features/real_state/domain/entity/real_estate.dart';
import 'package:real_state/features/real_state/presentation/widget/real_estate_images.dart';
import 'package:real_state/features/real_state/presentation/widget/real_estate_location_widget.dart';
import 'package:real_state/generated/generated_assets/assets.gen.dart';
import 'package:real_state/themes/app_theme.dart';

class RealEstateDetailsPage extends StatefulWidget {
  static const String path = '/real-estate-details';
  final RealEstate realEstate;

  const RealEstateDetailsPage({super.key, required this.realEstate});

  @override
  State<RealEstateDetailsPage> createState() => _RealEstateDetailsPageState();
}

class _RealEstateDetailsPageState extends State<RealEstateDetailsPage> {
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
                background: Container(
                  height: 320,
                  color: Colors.red,
                  width: MediaQuery.of(context).size.width,
                  child: RealEstateImages(
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
                    HeaderText(
                      title: widget.realEstate.title,
                      textStyle: Theme.of(context).textTheme.headlineSmall!
                          .copyWith(fontWeight: FontWeight.bold),
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
                    8.height(),
                    TextItemWidget(
                      title: context.translation.age,
                      description:
                          "${widget.realEstate.propertyAge} ${context.translation.year}",
                    ),
                    16.height(),
                    HeaderText(title: context.translation.location),
                    16.height(),
                    RealEstateLocationWidget(realEstate: widget.realEstate),
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
