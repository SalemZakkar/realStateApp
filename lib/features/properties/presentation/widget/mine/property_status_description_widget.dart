import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/page/about_us_page.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/call_us_dialog.dart';
import 'package:real_state/features/core/presentation/widget/dialogs/dialog_util.dart';
import 'package:real_state/features/properties/domain/entity/property.dart';
import 'package:real_state/features/properties/domain/enum/property_enum.dart';
import 'package:real_state/features/properties/presentation/cubits/property_status_cubit.dart';
import 'package:real_state/injection.dart';
import 'package:real_state/themes/app_theme.dart';

class PropertyStatusDescriptionWidget extends StatefulWidget {
  final Property property;

  const PropertyStatusDescriptionWidget({super.key, required this.property});

  @override
  State<PropertyStatusDescriptionWidget> createState() => _PropertyStatusDescriptionWidgetState();
}

class _PropertyStatusDescriptionWidgetState extends State<PropertyStatusDescriptionWidget> {
  var statusCubit = getIt<PropertyStatusCubit>();

  @override
  void dispose() {
    super.dispose();
    statusCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          spacing: 16,
          children: [
            if (widget.property.status == PropertyStatus.unCompleted &&
                widget.property.images.isEmpty) ...[
              Text(
                context
                    .translation
                    .dataIsUnCompletedYouShouldAddImagesToContinue,
              ),
            ],
            if (widget.property.status == PropertyStatus.unCompleted &&
                widget.property.images.isNotEmpty) ...[
              Text(context.translation.postIsReadyToSendToReview),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ScreenLoader(
                  cubit: statusCubit,
                  child: ElevatedButton(
                    onPressed: () {
                      DialogUtil(
                        context: context,
                        onAccept: () {
                          statusCubit.changeStatus(
                            widget.property.id,
                            PropertyStatus.pending,
                          );
                        },
                      ).showConfirmDialog(
                        message: context.translation.sendPostToReviewQ,
                      );
                    },
                    child: Text(context.translation.sendToReview),
                  ),
                ),
              ),
            ],
            if (widget.property.status == PropertyStatus.pending) ...[
              Text(
                context
                    .translation
                    .thePostIsCurrentlyInReviewPleaseWaitForAccepting,
              ),
            ],
            if (widget.property.status == PropertyStatus.active) ...[
              Text(context.translation.postIsActiveAndVisibleToAll),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.appColorSchema.statusColors.fail,
                  ),
                  onPressed: () {
                    DialogUtil(
                      context: context,
                      onAccept: () {
                        statusCubit.changeStatus(
                          widget.property.id,
                          PropertyStatus.unactive,
                        );
                      },
                    ).showConfirmDialog(
                      message: context.translation.doUWantToDeActivateThePost,
                    );
                  },
                  child: Text(context.translation.unActivate),
                ),
              ),
            ],
            if (widget.property.status == PropertyStatus.unactive) ...[
              Text(context.translation.postIsUnActivatedAndNotVisibleToAnyOne),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    DialogUtil(
                      context: context,
                      onAccept: () {
                        statusCubit.changeStatus(
                          widget.property.id,
                          PropertyStatus.active,
                        );
                      },
                    ).showConfirmDialog(
                      message: context.translation.doUWantToActivateThePost,
                    );
                  },
                  child: Text(context.translation.activate),
                ),
              ),
            ],
            if (widget.property.status == PropertyStatus.rejected) ...[
              Text(
                context
                    .translation
                    .postIsRejectedPleaseContactUsIfYouWantMoreInformation,
              ),
              if (widget.property.rejectReason != null) ...[
                Text(widget.property.rejectReason!),
              ],
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(context: context, builder: (context) => CallUsDialog());
                  },
                  child: Text(context.translation.contactUs),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
