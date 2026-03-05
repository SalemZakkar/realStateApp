import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/utils/ext/dynamic_svg_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/num.dart';
import 'package:real_state/features/core/presentation/utils/ext/string.dart';
import 'package:real_state/features/core/presentation/widget/contact_us_phone_buttons.dart';
import 'package:real_state/features/core/presentation/widget/main_map_page.dart';
import 'package:real_state/features/core/presentation/widget/video_player_widget.dart';
import 'package:real_state/features/properties/domain/entity/property.dart';
import 'package:real_state/features/properties/presentation/page/property_images_page.dart';
import 'package:real_state/features/properties/presentation/widget/property_category_type_widget.dart';
import 'package:real_state/features/properties/presentation/widget/property_details_card.dart';
import 'package:real_state/features/properties/presentation/widget/property_save_button.dart';
import 'package:real_state/generated/generated_assets/assets.gen.dart';
import 'package:real_state/themes/app_theme.dart';

class PropertyViewWidget extends StatefulWidget {
  final Property realEstate;

  const PropertyViewWidget({super.key, required this.realEstate});

  @override
  State<PropertyViewWidget> createState() => _PropertyViewWidgetState();
}

class _PropertyViewWidgetState extends State<PropertyViewWidget> {
  // Create a [VideoController] to handle video output from [Player].

  @override
  void initState() {
    // player.open(Media('https://download.samplelib.com/mp4/sample-5s.mp4') , play: false);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // player.dispose();
  }

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
              actions: [
                if (widget.realEstate.images.isNotEmpty == true) ...[
                  InkWellWithoutFeedback(
                    onTap: () {
                      context.push(
                        PropertyImagesPage.path,
                        extra: widget.realEstate,
                      );
                    },
                    child: Container(
                      width: 46,
                      height: 46,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: context.appColorSchema.shapeColors.cardColor,
                        shape: BoxShape.circle,
                      ),
                      child: Assets.icons.expand.dynamicSVGColor(context),
                    ),
                  ),
                  8.width(),
                ],
              ],
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
                    onTap: (v) {
                      if (widget.realEstate.images.isEmpty) {
                        return;
                      }
                      context.pushNamed(
                        PropertyImagesPage.path,
                        extra: widget.realEstate,
                      );
                    },
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
                        PropertySaveButton(
                          property: widget.realEstate.id,
                          isSaved: widget.realEstate.isSaved,
                        ),
                        // if (widget.realEstate.isFeature) ...[
                        //   8.width(),
                        //   Container(
                        //     padding: EdgeInsets.all(8),
                        //     decoration: BoxDecoration(
                        //       color: context.appColorSchema.statusColors.pending
                        //           .withValues(alpha: 0.2),
                        //       borderRadius: BorderRadius.circular(8),
                        //     ),
                        //     child: Text(
                        //       context.translation.featured,
                        //       style: TextStyle(
                        //         color:
                        //             context.appColorSchema.statusColors.pending,
                        //         fontWeight: FontWeight.bold,
                        //       ),
                        //     ),
                        //   ),
                        // ],
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: IconText(
                            icon: Assets.icons.maps.dynamicSVGColor(context),
                            text: widget.realEstate.city.name,
                          ),
                        ),
                        PropertyCategoryTypeWidget(property: widget.realEstate),
                      ],
                    ),
                    if (widget.realEstate.video != null)
                      VideoPlayerWidget(
                        size: Size(MediaQuery.of(context).size.width, 300),
                        url: widget.realEstate.video!.getUrl!,
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
                    PropertyDetailsCardWidget(realEstate: widget.realEstate),

                    MainMapWidget(
                      size: Size(MediaQuery.of(context).size.width, 300),
                      radius: BorderRadius.circular(12),
                      initial: widget.realEstate.coordinates,
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
