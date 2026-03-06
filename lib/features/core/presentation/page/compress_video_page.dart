
import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/cubit/compress_video_cubit.dart';
import 'package:real_state/features/core/presentation/cubit/video_thumbnail_cubit.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/themes/app_theme.dart';
import 'dart:io';
class CompressVideoPage extends StatefulWidget {
  static String path = "/CompressVideoPage";
  final String file;

  const CompressVideoPage({super.key, required this.file});

  @override
  State<CompressVideoPage> createState() => _CompressVideoPageState();
}

class _CompressVideoPageState extends State<CompressVideoPage> {
  late var thumbnail = VideoThumbnailCubit()..get(widget.file);
  var compress = CompressVideoCubit();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.translation.addVideo)),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16),
        constraints: const BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Column(
            spacing: 16,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ConsumerWidget(
                cubit: thumbnail,
                onDataReceived: (v) {
                  compress.compress(widget.file);
                },
                childBuilder: (context, state) {
                  if (state == null) {
                    return CustomCardWidget(
                      child: Icon(Icons.broken_image_sharp),
                    );
                  }
                  return Container(
                    constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width,
                      maxHeight: 350,
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(6),
                          child: Image.file(
                            File(state),
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                        Positioned.fill(
                          child: Container(
                            alignment: Alignment.center,
                            color: Colors.black.withValues(alpha: 0.5),
                            child: Text(
                              context.translation.preparing,
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                onRetry: null,
              ),
              BlocConsumer<CompressVideoCubit, CompressVideoState>(
                listener: (context, state) {
                  if (state.path != null) {
                    context.pop(state.path!);
                  }
                },
                bloc: compress,
                builder: (context, state) {
                  return Column(
                    spacing: 16,
                    children: [
                      LinearProgressIndicator(
                        color: state.fail == true
                            ? context.appColorSchema.statusColors.fail
                            : Theme.of(context).primaryColor,
                        value: state.progress,
                      ),
                      if (state.fail == true) ...[
                        Text(context.translation.errorMessage),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                context.appColorSchema.statusColors.fail,
                          ),
                          onPressed: () {
                            compress.compress(widget.file);
                          },
                          child: Text(context.translation.retry),
                        ),
                      ],
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
