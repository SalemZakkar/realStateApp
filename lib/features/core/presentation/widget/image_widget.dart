// ignore_for_file: unused_element

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:platform_identity/platform_identity.dart';
import 'package:real_state/themes/app_theme.dart';

class ImageWidget extends StatefulWidget {
  final String? url;
  final Widget? placeHolder;
  final Duration? hideSettingsDuration;
  final BoxShape? shape;
  final BorderRadius? borderRadius;
  final double? radius, width, height;
  final VoidCallback? onDelete;
  final ValueChanged<ImageProvider>? onCreated;
  final ValueChanged<ImageProvider>? onTap;
  final BoxFit? fit;

  const ImageWidget({
    super.key,
    this.shape,
    this.height,
    this.width,
    this.radius,
    this.url,
    this.hideSettingsDuration,
    this.onDelete,
    this.borderRadius,
    this.placeHolder,
    this.onCreated,
    this.fit,
    this.onTap,
  });

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  ImageProvider? provider;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: widget.shape == BoxShape.circle
          ? (widget.radius ?? 100)
          : widget.width ?? 100,
      height: widget.shape == BoxShape.circle
          ? (widget.radius ?? 100)
          : widget.height ?? 100,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            top: 0,
            child: Container(
              clipBehavior: Clip.antiAlias,
              width: widget.shape == BoxShape.circle
                  ? (widget.radius ?? 100)
                  : widget.width ?? 100,
              height: widget.shape == BoxShape.circle
                  ? (widget.radius ?? 100)
                  : widget.height ?? 100,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: widget.shape == BoxShape.circle
                    ? null
                    : widget.borderRadius,
                shape: widget.shape ?? BoxShape.rectangle,
              ),
              child: (widget.url != null
                  ? CachedNetworkImage(
                      httpHeaders: {
                        "appversion": PlatformIdentity.getAppVersion(),
                      },
                      imageUrl: widget.url!,
                      // placeholder: (context, url) => const Loader(),
                      imageBuilder: (context, provider) {
                        widget.onCreated?.call(provider);
                        this.provider = provider;
                        return Image(
                          image: provider,
                          // color: Colors.red,
                          // colorBlendMode: BlendMode.dstOut,
                          fit: widget.fit ?? BoxFit.cover,
                        );
                      },
                    )
                  : widget.placeHolder ??
                        Icon(
                          Icons.image,
                          size: 40,
                          color: context.appColorSchema.primaryColor.withValues(
                            alpha: 0.8,
                          ),
                        )),
            ),
          ),
        ],
      ),
    );
  }
}

// class _ImageSheetWidget extends StatefulWidget {
//   final ValueChanged<PickFile> onChanged;
//
//   const _ImageSheetWidget({required this.onChanged});
//
//   @override
//   State<_ImageSheetWidget> createState() => _ImageSheetWidgetState();
// }
//
// class _ImageSheetWidgetState extends State<_ImageSheetWidget> {
//   void pickGallery() async {
//     var res = await FilePickUtil.getImage(source: ImageSource.gallery);
//     if (res != null) {
//       widget.onChanged(res);
//     }
//   }
//
//   void pickCamera() async {
//     var res = await FilePickUtil.getImage(source: ImageSource.camera);
//     if (res != null) {
//       widget.onChanged(res);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return RegularBottomSheetLayout(
//         height: 160,
//         title: context.translation.editImage,
//         body: const Padding(
//           padding: EdgeInsets.only(top: 10.0, left: 4),
//           child: Column(
//             children: [
//               // _SheetItemWidget(
//               //   onTap: () {
//               //     pickGallery();
//               //     Navigator.pop(context);
//               //   },
//               //   title: context.translation.photoGallery,
//               //   iconFromUtilsPackage: true,
//               //   iconSVG: utils_assets.Assets.icons.galleryAdd.path,
//               // ),
//               // _SheetItemWidget(
//               //   onTap: () {
//               //     pickCamera();
//               //     Navigator.pop(context);
//               //   },
//               //   title: context.translation.camera,
//               //   iconSVG: Assets.icons.pickImageFromCamera.path,
//               //   padding: EdgeInsets.zero,
//               // ),
//             ],
//           ),
//         ));
//   }
// }
//
// class _SheetItemWidget extends StatelessWidget {
//   final void Function() onTap;
//   final String title;
//   final String iconSVG;
//   final bool iconFromUtilsPackage;
//   final EdgeInsets? padding;
//
//   const _SheetItemWidget({
//     required this.onTap,
//     required this.title,
//     required this.iconSVG,
//     this.iconFromUtilsPackage = false,
//     this.padding,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Padding(
//         padding: padding ?? const EdgeInsets.only(bottom: 16.0),
//         child: Row(
//           children: [
//             // Padding(
//             //   padding: const EdgeInsets.only(right: 16.0),
//             //   child: iconSVG.dynamicSVGColor(
//             //     context,
//             //     package: iconFromUtilsPackage
//             //         ? UtilsConstants.alefPackageUtils
//             //         : null,
//             //     color: context.primaryColor,
//             //     width: 16,
//             //     height: 16,
//             //   ),
//             // ),
//             Text(title),
//           ],
//         ),
//       ),
//     );
//   }
// }
