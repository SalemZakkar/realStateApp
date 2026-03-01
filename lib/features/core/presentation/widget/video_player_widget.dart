import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:real_state/features/core/presentation/cubit/video_cubit.dart';
import 'package:real_state/injection.dart';

class VideoPlayerWidget extends StatefulWidget {
  final Size size;
  final String url;

  const VideoPlayerWidget({super.key, required this.size, required this.url});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  var cubit = getIt<VideoCubit>();

  @override
  void initState() {
    super.initState();
    cubit.get(widget.url);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.hardEdge,
      padding: EdgeInsets.only(bottom: 8),
      width: widget.size.width,
      height: widget.size.height,
      child: ConsumerWidget(
        cubit: cubit,
        childBuilder: (context, state) {
          return Video(
            controller: state,
            wakelock: true,
            pauseUponEnteringBackgroundMode: true,
            resumeUponEnteringForegroundMode: false,
          );
        },
        onRetry: () {
          cubit.get(widget.url);
        },
      ),
    );
  }
}
