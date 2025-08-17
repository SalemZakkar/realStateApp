import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/utils/ext/num_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/chips_widget.dart';
import 'package:real_state/features/core/presentation/widget/sheets/regular_bottom_sheet_layout.dart';
import 'package:real_state/features/core/presentation/widget/text/header_text.dart';
import 'package:real_state/features/real_state/domain/enum/property_deed_type.dart';
import 'package:real_state/features/real_state/domain/enum/property_type.dart';
import 'package:real_state/features/real_state/domain/params/real_estate_get_params.dart';

class RealEstateFilterSheet extends StatefulWidget {
  final RealEstateGetParams? params;
  final ValueChanged<RealEstateGetParams> onChanged;

  const RealEstateFilterSheet({
    super.key,
    this.params,
    required this.onChanged,
  });

  @override
  State<RealEstateFilterSheet> createState() => _RealEstateFilterSheetState();
}

class _RealEstateFilterSheetState extends State<RealEstateFilterSheet> {
  @override
  void initState() {
    super.initState();
    min = 0;
    max = 10000000000;
    priceRange = RangeValues(min, max);
    if (widget.params != null) {
      params.city = widget.params!.city;
      params.title = widget.params!.title;
      params.maxPrice = widget.params!.maxPrice;
      params.minPrice = widget.params!.minPrice;
      params.propertyDeedType = widget.params!.propertyDeedType;
      params.propertyType = widget.params!.propertyType;
    }
  }

  late double min, max;
  late RangeValues priceRange;

  RealEstateGetParams params = RealEstateGetParams(page: 1, limit: 10);

  @override
  Widget build(BuildContext context) {
    return RegularBottomSheetLayout(
      title: context.translation.search,
      body: Column(
        // mainAxisSize: MainAxisSize.min,
        children: [
          HeaderText(title: context.translation.propertyType),
          8.height(),
          ChipsWidget(
            onSelect: (b) {
              params.propertyType = b;
              setState(() {});
            },
            selected: params.propertyType,
            spacing: 8,
            items: RealEstatePropertyType.values,
            getString: (v) {
              return context.translation.propertyTypeE(v.name);
            },
          ),
          16.height(),
          HeaderText(
            title: context.translation.propertyDeed,
            textStyle: Theme.of(context).textTheme.titleLarge,
          ),
          8.height(),
          ChipsWidget(
            onSelect: (b) {
              params.propertyDeedType = b;
              setState(() {});
            },
            selected: params.propertyDeedType,
            spacing: 8,
            items: RealEstatePropertyDeedType.values,
            getString: (v) {
              return context.translation.propertyDeedE(v.name);
            },
          ),
          16.height(),

        ],
      ),
    );
  }
}
