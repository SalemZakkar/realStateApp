import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/cubit/video_thumbnail_cubit.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/properties/presentation/cubits/property_upload_video_cubit.dart';
import 'dart:io';

import 'package:real_state/injection.dart';
import 'package:real_state/themes/app_theme.dart';

class PropertyUploadVideoPage extends StatefulWidget {
  static String path = "/PropertyUploadVideo/:file/:id";
  final String file;
  final String id;

  const PropertyUploadVideoPage({
    super.key,
    required this.file,
    required this.id,
  });

  @override
  State<PropertyUploadVideoPage> createState() =>
      _PropertyUploadVideoPageState();
}

class _PropertyUploadVideoPageState extends State<PropertyUploadVideoPage> {
  late var thumbnail = VideoThumbnailCubit()..get(widget.file);
  var cubit = getIt<PropertyUploadVideoCubit>();

  @override
  void initState() {
    cubit.upload(widget.id, widget.file);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    cubit.close();
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
              Container(
                constraints: BoxConstraints(maxHeight: 250),
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ConsumerWidget(
                        cubit: thumbnail,
                        childBuilder: (context, state) {
                          if (state == null) {
                            return CustomCardWidget(
                              child: Icon(Icons.broken_image_sharp),
                            );
                          }
                          return ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(6),
                            child: Image.file(
                              File(state),
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                            ),
                          );
                        },
                        onRetry: null,
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
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child:
                    BlocConsumer<
                      PropertyUploadVideoCubit,
                      PropertyUploadVideoState
                    >(
                      bloc: cubit,
                      listener: (context, state) {
                        if (state.done) {
                          context.pop();
                        }
                      },
                      builder: (context, state) {
                        return Column(
                          spacing: 16,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (state.progress != null) ...[
                              Text(
                                context
                                    .translation
                                    .videoIsBeingUploadedClosingTheScreenWillCancelTheOperation,
                              ),
                            ],
                            if (state.failure == null) ...[
                              LinearProgressIndicator(
                                value: state.progress == 1
                                    ? null
                                    : state.progress,
                                color: Theme.of(context).primaryColor,
                              ),
                            ],
                            if (state.failure != null) ...[
                              ErrorView(
                                failure: state.failure!,
                                onRetry: () {
                                  cubit.upload(widget.id, widget.file);
                                },
                              ),
                            ],
                            //error
                          ],
                        );
                      },
                    ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.appColorSchema.statusColors.fail,
                ),
                onPressed: () {
                  context.pop();
                },
                child: Text(context.translation.cancel),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
