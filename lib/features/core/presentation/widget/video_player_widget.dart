import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';

import 'package:real_state/features/core/presentation/utils/ext/string.dart';
import 'package:real_state/features/core/presentation/utils/file_manager.dart';
import 'package:real_state/injection.dart';

// import 'package:real_state/injection.dart';
import 'package:url_launcher/url_launcher.dart';

// class VideoPlayerWidget extends StatefulWidget {
//   final Size size;
//   final String url;
//
//   const VideoPlayerWidget({super.key, required this.size, required this.url});
//
//   @override
//   State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
// }
//
// class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
//   var cubit = getIt<VideoCubit>();
//   bool absorbing = false;
//
//   @override
//   void initState() {
//     super.initState();
//     cubit.get(widget.url);
//   }
//
//   @override
//   void didUpdateWidget(covariant VideoPlayerWidget oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.url != oldWidget.url) {
//       cubit.get(widget.url);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Theme.of(context).cardColor,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       clipBehavior: Clip.hardEdge,
//       padding: EdgeInsets.only(bottom: 8),
//       width: widget.size.width,
//       height: widget.size.height,
//       child: ConsumerWidget(
//         cubit: cubit,
//         childBuilder: (context, state) {
//           return Video(
//             fill: Theme.of(context).cardColor,
//             controller: state,
//             wakelock: true,
//             pauseUponEnteringBackgroundMode: true,
//             resumeUponEnteringForegroundMode: false,
//           );
//         },
//         onRetry: () {
//           cubit.get(widget.url);
//         },
//       ),
//     );
//   }
// }

class VideoThumbnailWidget extends StatefulWidget {
  final String id;
  final Size size;

  const VideoThumbnailWidget({super.key, required this.id, required this.size});

  @override
  State<VideoThumbnailWidget> createState() => _VideoThumbnailWidgetState();
}

class _VideoThumbnailWidgetState extends State<VideoThumbnailWidget> {
  // var c = VideoThumbnailCubit();

  @override
  void initState() {
    super.initState();
    // c.getUrl(widget.url);
  }

  @override
  void didUpdateWidget(covariant VideoThumbnailWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // if (widget.url != oldWidget.url) {
    // c.getUrl(widget.url);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return InkWellWithoutFeedback(
      onTap: () {
        launchUrl(Uri.parse(widget.id.getUrl!));
        // context.push(PlayVideoPage.path, extra: widget.url);
      },
      child: Container(
        width: widget.size.width,
        height: widget.size.height,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            ImageWidget(
              width: widget.size.width,
              height: widget.size.height,
              url: getIt<FileManager>().getVideoThumbnail(name: widget.id),
              errorWidget: Center(child: Icon(Icons.broken_image)),
              fit: BoxFit.cover,
            ),
            Container(color: Colors.black.withValues(alpha: 0.5)),
            Center(
              child: Icon(Icons.play_arrow, color: Colors.white, size: 80),
            ),
          ],
        ),
      ),
    );
  }
}
