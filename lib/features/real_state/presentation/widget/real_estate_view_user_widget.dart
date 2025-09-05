import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:real_state/features/core/presentation/utils/ext/dynamic_svg_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/num_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/bloc_consumers/screen_loader.dart';
import 'package:real_state/features/core/presentation/widget/buttons/inkwell_without_feedback.dart';
import 'package:real_state/features/core/presentation/widget/custom_card_widget.dart';
import 'package:real_state/features/core/presentation/widget/dialogs/dialog_util.dart';
import 'package:real_state/features/core/presentation/widget/images_widget.dart';
import 'package:real_state/features/core/presentation/widget/map_cluster_widget.dart';
import 'package:real_state/features/core/presentation/widget/map_widget.dart';
import 'package:real_state/features/core/presentation/widget/sheets/contact_us_sheet.dart';
import 'package:real_state/features/core/presentation/widget/text/header_text.dart';
import 'package:real_state/features/core/presentation/widget/text/icon_text.dart';
import 'package:real_state/features/core/presentation/widget/text/text_item_widget.dart';
import 'package:real_state/features/real_state/domain/entity/real_estate.dart';
import 'package:real_state/features/real_state/domain/enum/real_estate_post_status.dart';
import 'package:real_state/features/real_state/presentation/cubit/real_estate_delete_cubit.dart';
import 'package:real_state/features/real_state/presentation/page/real_estate_form_page.dart';
import 'package:real_state/features/real_state/presentation/page/real_estate_image_page.dart';
import 'package:real_state/features/real_state/presentation/widget/real_estate_change_status_widget.dart';
import 'package:real_state/features/real_state/presentation/widget/real_estate_status_widget.dart';
import 'package:real_state/generated/generated_assets/assets.gen.dart';
import 'package:real_state/injection.dart';
import 'package:real_state/themes/app_theme.dart';

class RealEstateViewUserWidget extends StatefulWidget {
  final RealEstate realEstate;

  const RealEstateViewUserWidget({super.key, required this.realEstate});

  @override
  State<RealEstateViewUserWidget> createState() =>
      _RealEstateViewUserWidgetState();
}

class _RealEstateViewUserWidgetState extends State<RealEstateViewUserWidget> {
  var del = getIt<RealEstateDeleteCubit>();

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
              actions: [
                if (widget.realEstate.editable) ...[
                  InkWellWithoutFeedback(
                    onTap: () {
                      context.push(
                        RealEstateFormPage.path,
                        extra: widget.realEstate,
                      );
                    },
                    child: Container(
                      width: 48,
                      height: 48,
                      // margin: EdgeInsets.all(6),
                      alignment: Alignment.center,
                      // margin: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: context.appColorSchema.shapeColors.cardColor,
                        shape: BoxShape.circle,
                      ),
                      child: Assets.icons.edit.dynamicSVGColor(context),
                    ),
                  ),
                  8.width(),
                ],
                ScreenLoader(
                  cubit: del,
                  withSuccess: false,
                  onSuccess: (v) {
                    context.pop();
                  },
                  child: InkWellWithoutFeedback(
                    onTap: () {
                      DialogUtil(
                        context: context,
                        onDone: () {
                          del.delete(id: widget.realEstate.id);
                        },
                      ).showConfirmDialog(
                        message: context.translation.thePropertyWillBeDeleted,
                      );
                    },
                    child: Container(
                      width: 48,
                      height: 48,
                      // margin: EdgeInsets.all(6),
                      alignment: Alignment.center,
                      // margin: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: context.appColorSchema.shapeColors.cardColor,
                        shape: BoxShape.circle,
                      ),
                      child: Assets.icons.delete.dynamicSVGColor(
                        context,
                        color: context.appColorSchema.statusColors.fail,
                      ),
                    ),
                  ),
                ),
                8.width(),
              ],
              // backgroundColor: Colors.red,
              flexibleSpace: FlexibleSpaceBar(
                title: null,
                titlePadding: EdgeInsets.zero,

                stretchModes: [StretchMode.blurBackground],
                background: SizedBox(
                  height: 320,
                  // color: Colors.red,
                  width: MediaQuery.of(context).size.width,
                  child: widget.realEstate.images.isEmpty
                      ? CustomCardWidget(
                          borderRadius: BorderRadius.zero,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              Assets.icons.building.dynamicSVGColor(
                                context,
                                width: 48,
                                height: 48,
                              ),
                              16.height(),
                              Text(
                                context
                                    .translation
                                    .pleaseMakeSureYouAddedImages,
                                textAlign: TextAlign.center,
                              ),
                              8.height(),
                              ElevatedButton(
                                onPressed: () {
                                  context.push(
                                    RealEstateImagePage.path,
                                    extra: widget.realEstate,
                                  );
                                },
                                child: Text(context.translation.addImage),
                              ),
                            ],
                          ),
                        )
                      : ImagesWidget(
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
                    if (widget.realEstate.postStatus ==
                        RealEstatePostStatus.pending) ...[
                      16.height(),
                      CustomCardWidget(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Align(
                            alignment: AlignmentDirectional.topStart,
                            child: Text(
                              context.translation.propertyAddMessageWarning,
                            ),
                          ),
                        ),
                      ),
                    ],
                    if (widget.realEstate.postStatus ==
                        RealEstatePostStatus.rejected) ...[
                      16.height(),
                      CustomCardWidget(
                        backgroundColor:
                            context.appColorSchema.statusColors.fail,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Align(
                            alignment: AlignmentDirectional.topStart,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  context.translation.rejected,
                                  style: TextStyle(color: Colors.white),
                                ),
                                8.height(),
                                Text(
                                  widget.realEstate.rejectReason ?? '',

                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                    16.height(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            widget.realEstate.title,
                            style: Theme.of(context).textTheme.headlineMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        RealEstateStatusWidget(estate: widget.realEstate),
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
                    RealEstateChangeStatusWidget(
                      realEstate: widget.realEstate,
                      onChanged: (v) {},
                    ),
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
