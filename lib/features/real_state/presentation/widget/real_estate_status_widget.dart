import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/custom_card_widget.dart';
import 'package:real_state/features/real_state/domain/entity/real_estate.dart';
import 'package:real_state/features/real_state/domain/enum/real_estate_status.dart';
import 'package:real_state/themes/app_theme.dart';

class RealEstateStatusWidget extends StatefulWidget {
  final RealEstate estate;
  final bool withOpacity;

  const RealEstateStatusWidget({
    super.key,
    required this.estate,
    this.withOpacity = true,
  });

  @override
  State<RealEstateStatusWidget> createState() => _RealEstateStatusWidgetState();
}

class _RealEstateStatusWidgetState extends State<RealEstateStatusWidget> {
  Color getStatusColor(RealEstateStatus status) {
    switch (status) {
      case RealEstateStatus.available:
        return context.appColorSchema.statusColors.success;
      case RealEstateStatus.sold:
        return context.appColorSchema.statusColors.fail;

      case RealEstateStatus.rented:
        return context.appColorSchema.statusColors.fail;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      backgroundColor: getStatusColor(
        widget.estate.status,
      ).withValues(alpha: widget.withOpacity ? 0.1 : 1),
      padding: EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(4),
      child: SizedBox(
        // width: MediaQuery.of(context).size.width,
        child: Text(
          context.translation.realEstateStatusE(widget.estate.status.name),
          style: TextStyle(
            color: !widget.withOpacity
                ? Colors.white
                : getStatusColor(widget.estate.status),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
