import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/page/compress_video_page.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/dialogs/dialog_util.dart';
import 'package:real_state/features/core/presentation/widget/video_player_widget.dart';
import 'package:real_state/features/properties/domain/entity/property.dart';
import 'package:real_state/features/properties/presentation/cubits/property_file_cubit.dart';
import 'package:real_state/injection.dart';
import 'package:real_state/themes/app_theme.dart';

class PropertyMineVideoWidget extends StatefulWidget {
  final Property property;

  const PropertyMineVideoWidget({super.key, required this.property});

  @override
  State<PropertyMineVideoWidget> createState() =>
      _PropertyMineVideoWidgetState();
}

class _PropertyMineVideoWidgetState extends State<PropertyMineVideoWidget> {
  final cubit = getIt<PropertyFileCubit>();

  @override
  void didUpdateWidget(covariant PropertyMineVideoWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLoader(
      cubit: cubit,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          spacing: 8,
          children: [
            if (widget.property.video == null && widget.property.editable) ...[
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: OutlinedButton(
                  onPressed: () async {
                    var res = await FilePickUtil.getVideo(quality: 40);
                    if (res != null) {
                      if (context.mounted) {
                        context.pushNamed(
                          PropertyUploadVideoPage.path,
                          pathParameters: {
                            "file": res.path,
                            "id": widget.property.id,
                          },
                        );
                      }
                    }
                  },
                  child: Text(context.translation.addVideo),
                ),
              ),
            ],
            if (widget.property.video != null) ...[
              VideoThumbnailWidget(
                size: Size(MediaQuery.of(context).size.width, 300),
                id: widget.property.video!,
              ),
              if (widget.property.editable) ...[
                Row(
                  spacing: 8,
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                context.appColorSchema.statusColors.fail,
                          ),
                          onPressed: () {
                            DialogUtil(
                              context: context,
                              onAccept: () {
                                cubit.deleteVideo(
                                  widget.property.id,
                                  widget.property.video!,
                                );
                              },
                            ).showConfirmDialog(
                              message: context.translation.deleteVideoQuestion,
                            );
                          },
                          child: Text(context.translation.deleteVideo),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: () async {
                            var res = await FilePickUtil.getVideo(quality: 40);

                            if (res != null) {
                              if (context.mounted) {
                                context.pushNamed(
                                  PropertyUploadVideoPage.path,
                                  pathParameters: {
                                    "file": res.path,
                                    "id": widget.property.id,
                                  },
                                );
                              }
                            }
                          },
                          child: Text(context.translation.changeVideo),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
