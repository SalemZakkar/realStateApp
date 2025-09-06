import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/utils/ext/num_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/custom_card_widget.dart';
import 'package:real_state/features/real_state/domain/entity/real_estate.dart';
import 'package:real_state/features/real_state/domain/enum/real_estate_post_status.dart';
import 'package:real_state/themes/app_theme.dart';

class RealEstatePostStatusWidget extends StatefulWidget {
  final RealEstate estate;

  const RealEstatePostStatusWidget({super.key, required this.estate});

  @override
  State<RealEstatePostStatusWidget> createState() =>
      _RealEstatePostStatusWidgetState();
}

class _RealEstatePostStatusWidgetState
    extends State<RealEstatePostStatusWidget> {
  Color getStatusColor(RealEstatePostStatus status) {
    switch (status) {
      case RealEstatePostStatus.pending:
        return context.appColorSchema.statusColors.pending;
      case RealEstatePostStatus.rejected:
        return context.appColorSchema.statusColors.fail;

      case RealEstatePostStatus.approved:
        return context.appColorSchema.statusColors.success;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomCardWidget(
          backgroundColor: getStatusColor(
            widget.estate.postStatus,
          ).withValues(alpha: 0.1),
          padding: EdgeInsets.all(8),
          borderRadius: BorderRadius.circular(4),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Text(
              context.translation.propertyPostStatusE(
                widget.estate.postStatus.name,
              ),
              style: TextStyle(
                color: getStatusColor(widget.estate.postStatus),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        if (widget.estate.postStatus == RealEstatePostStatus.pending) ...[
          8.height(),
          CustomCardWidget(
            padding: EdgeInsets.all(16),
            borderRadius: BorderRadius.circular(4),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(context.translation.propertyAddMessageWarning),
              ),
            ),
          ),
        ],
        if (widget.estate.rejectReason != null &&
            widget.estate.postStatus == RealEstatePostStatus.rejected) ...[
          8.height(),
          CustomCardWidget(
            padding: EdgeInsets.all(16),
            borderRadius: BorderRadius.circular(4),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(widget.estate.rejectReason ?? ''),
            ),
          ),
        ],
      ],
    );
  }
}
