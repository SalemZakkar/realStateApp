import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/status_card.dart';
import 'package:real_state/features/properties/domain/entity/property.dart';
import 'package:real_state/features/properties/domain/enum/property_enum.dart';
import 'package:real_state/themes/app_theme.dart';

class PropertyCategoryTypeWidget extends StatefulWidget {
  final Property property;

  const PropertyCategoryTypeWidget({super.key, required this.property});

  @override
  State<PropertyCategoryTypeWidget> createState() =>
      _PropertyCategoryTypeWidgetState();
}

class _PropertyCategoryTypeWidgetState
    extends State<PropertyCategoryTypeWidget> {
  @override
  Widget build(BuildContext context) {
    return StatusCard(
      color: () {
        if (widget.property.category == PropertyCategory.buy) {
          return context.appColorSchema.statusColors.success;
        }
        if (widget.property.category == PropertyCategory.rent) {
          return Theme.of(context).primaryColor;
        }
        return context.appColorSchema.statusColors.fail;
      }.call(),
      title: context.translation.categoryE(widget.property.category.name),
    );
  }
}
