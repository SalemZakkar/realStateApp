import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/utils/ext/dynamic_svg_ext.dart';
import 'package:real_state/features/core/presentation/widget/buttons/inkwell_without_feedback.dart';
import 'package:real_state/features/core/presentation/widget/image_widget.dart';
import 'package:real_state/generated/generated_assets/assets.gen.dart';
import 'package:real_state/themes/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class RealEstateImages extends StatefulWidget {
  final List<String> images;
  final double height;

  const RealEstateImages({
    super.key,
    required this.images,
    required this.height,
  });

  @override
  State<RealEstateImages> createState() => _RealEstateImagesState();
}

class _RealEstateImagesState extends State<RealEstateImages> {
  int index = 0;
  CarouselSliderController controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            top: 0,
            left: 0,
            right: 0,
            child: CarouselSlider(
              carouselController: controller,
              items: widget.images
                  .map(
                    (e) => InkWellWithoutFeedback(
                      onTap: () {
                        launchUrl(
                          Uri.parse(e),
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      child: ImageWidget(
                        url: e,
                        width: MediaQuery.of(context).size.width,
                        height: widget.height,
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                viewportFraction: 1,
                height: double.infinity,
                // autoPlay: true,
                onPageChanged: (i, c) {
                  setState(() {
                    index = i;
                  });
                },
              ),
            ),
          ),
          Positioned(
            bottom: 8,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 8.width(),
                InkWellWithoutFeedback(
                  onTap: () {
                    index--;
                    if (index < 0) {
                      index = 0;
                    }
                    controller.animateToPage(index);
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    child: Icon(
                      Icons.arrow_back,

                      color: context.appColorSchema.shapeColors.iconColor,

                    ),
                  ),
                ),
                InkWellWithoutFeedback(
                  onTap: () {
                    launchUrl(
                      Uri.parse(widget.images[index]),
                      mode: LaunchMode.externalApplication,
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    child: Assets.icons.expand.dynamicSVGColor(
                      context,
                      color: context.appColorSchema.shapeColors.iconColor,
                    ),
                  ),
                ),
                InkWellWithoutFeedback(
                  onTap: () {
                    index++;
                    if (index >= widget.images.length) {
                      index = widget.images.length - 1;
                    }
                    controller.animateToPage(index);
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    child: Icon(
                      Icons.arrow_forward_outlined,
                      color: context.appColorSchema.shapeColors.iconColor,

                    ),
                  ),
                ),
                // 8.width(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
