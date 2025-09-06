import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/utils/ext/format_to_normal.dart';
import 'package:real_state/features/real_state/domain/entity/real_estate.dart';
import 'package:real_state/generated/generated_assets/assets.gen.dart';
import 'package:real_state/themes/app_theme.dart';

class RealEstateMarkerWidget extends StatelessWidget {
  final RealEstate realEstate;
  final Size size;

  const RealEstateMarkerWidget({
    super.key,
    required this.realEstate,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height,
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              color: realEstate.isFeature
                  ? context.appColorSchema.gold
                  : context.appColorSchema.primaryColor,
              borderRadius: BorderRadius.circular(4),
            ),
            padding: const EdgeInsets.all(4),
            child: Text(
              realEstate.price.toStringAsFixed(0).formatNumberWithPrecision(2),
              style: TextStyle(fontSize: 12),
            ),
          ),
          if (realEstate.isFeature)
            Assets.icons.mapFeaturedMarker.svg(width: 35, height: 35)
          else
            Assets.icons.mapMarker.svg(width: 35, height: 35),
        ],
      ),
    );
  }
}
