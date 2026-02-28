import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:real_state/features/core/presentation/utils/ext/string.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/properties/domain/entity/property.dart';

class PropertyImagesPage extends StatefulWidget {
  static String path = "/PropertyImagesPage";
  final Property property;

  const PropertyImagesPage({super.key, required this.property});

  @override
  State<PropertyImagesPage> createState() => _PropertyImagesPageState();
}

class _PropertyImagesPageState extends State<PropertyImagesPage> {
  String url = '';
  PageController pageController = PageController();
  int index = 0;

  @override
  void initState() {
    super.initState();
    url = widget.property.images.firstOrNull ?? '';
    pageController.addListener(() {
      if (pageController.page == pageController.page?.toInt()) {
        index = pageController.page?.toInt() ?? 0;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.translation.images)),
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: widget.property.images.length,
                itemBuilder: (context, index) {
                  return PhotoView(
                    backgroundDecoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    imageProvider: NetworkImage(
                      widget.property.images[index].getUrl!,
                    ),
                    minScale: PhotoViewComputedScale.contained,
                    maxScale: PhotoViewComputedScale.covered * 2,
                  );
                },
              ),
            ),
            16.height(),
            SliderStep(
              length: widget.property.images.length,
              index: index,
              onTap: (v) {
                pageController.jumpToPage(v);
              },
            ),
            16.height(),
          ],
        ),
      ),
    );
  }
}

// Column(
// children: [
// Expanded(
// child: PhotoView(
// imageProvider: NetworkImage(url.getUrl!),
//
// minScale: PhotoViewComputedScale.contained,
// ),
// ),
// // SizedBox(
// //   height: 166,
// //   child: ListView.separated(
// //     padding: EdgeInsets.symmetric(horizontal: 16),
// //     separatorBuilder: (context, index) => 16.width(),
// //     scrollDirection: Axis.horizontal,
// //     itemCount: widget.property.images.length,
// //     itemBuilder: (context, index) {
// //       return Container(
// //         decoration: BoxDecoration(
// //           borderRadius: BorderRadius.circular(12),
// //           border: url == widget.property.images[index]
// //               ? Border.all(
// //                   color: Theme.of(context).primaryColor,
// //                   width: 6,
// //                 )
// //               : null,
// //         ),
// //         child: InkWellWithoutFeedback(
// //           onTap: () {
// //             setState(() {
// //               url = widget.property.images[index];
// //             });
// //           },
// //           child: ImageWidget(
// //             width: 166,
// //             url: widget.property.images[index].getUrl!,
// //             borderRadius: BorderRadius.circular(6),
// //           ),
// //         ),
// //       );
// //     },
// //   ),
// // ),
// // 16.height(),
// ],
// )
