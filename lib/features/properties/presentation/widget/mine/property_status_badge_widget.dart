import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/properties/domain/enum/property_enum.dart';
import 'package:real_state/themes/app_theme.dart';

class PropertyStatusBadgeWidget extends StatelessWidget {
  final PropertyStatus status;

  const PropertyStatusBadgeWidget({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: _color(context, status).withValues(alpha: 0.1),
      ),
      child: Text(
        context.translation.realEstateStatusE(status.name),
        style: TextStyle(color: _color(context, status)),
      ),
    );
  }
}

Color _color(BuildContext context, PropertyStatus status) {
  if (status == PropertyStatus.unCompleted) {
    return context.appColorSchema.statusColors.fail;
  }
  if (status == PropertyStatus.pending) {
    return context.appColorSchema.statusColors.pending;
  }
  if (status == PropertyStatus.active) {
    return context.appColorSchema.statusColors.success;
  }
  if (status == PropertyStatus.unactive) {
    return context.appColorSchema.primaryColor;
  }
  return context.appColorSchema.statusColors.fail;
}
