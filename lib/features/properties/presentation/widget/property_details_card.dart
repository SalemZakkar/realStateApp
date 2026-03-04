import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/properties/domain/entity/property.dart';

class PropertyDetailsCardWidget extends StatefulWidget {
  final Property realEstate;

  const PropertyDetailsCardWidget({super.key, required this.realEstate});

  @override
  State<PropertyDetailsCardWidget> createState() => _PropertyDetailsCardWidgetState();
}

class _PropertyDetailsCardWidgetState extends State<PropertyDetailsCardWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      child: Column(
        spacing: 8,
        children: [
          if (widget.realEstate.neighborhood != null) ...[
            TextItemWidget(
              crossAxisAlignment: CrossAxisAlignment.start,
              minTitleWidth: 70,
              title: context.translation.neighborhood,
              titleStyle: Theme.of(context).textTheme.bodyLarge,
              description: (widget.realEstate.neighborhood ?? ''),
            ),
          ],
          if (widget.realEstate.address != null) ...[
            TextItemWidget(
              crossAxisAlignment: CrossAxisAlignment.start,
              minTitleWidth: 70,
              title: context.translation.address,
              titleStyle: Theme.of(context).textTheme.bodyLarge,
              description: (widget.realEstate.address ?? ''),
            ),
          ],
          TextItemWidget(
            minTitleWidth: 70,
            crossAxisAlignment: CrossAxisAlignment.start,
            title: context.translation.propertyDeed,
            titleStyle: Theme.of(context).textTheme.bodyLarge,
            description: context.translation.propertyDeedE(
              widget.realEstate.propertyDeedType.name,
            ),
          ),
          TextItemWidget(
            minTitleWidth: 70,
            crossAxisAlignment: CrossAxisAlignment.start,
            title: context.translation.theStocks,
            titleStyle: Theme.of(context).textTheme.bodyLarge,
            description: widget.realEstate.stocks.toString(),
          ),
          TextItemWidget(
            minTitleWidth: 70,
            crossAxisAlignment: CrossAxisAlignment.start,
            title: context.translation.rooms,
            titleStyle: Theme.of(context).textTheme.bodyLarge,
            description: widget.realEstate.room.toString(),
          ),
          if (widget.realEstate.address != null) ...[
            TextItemWidget(
              minTitleWidth: 70,
              crossAxisAlignment: CrossAxisAlignment.start,
              title: context.translation.address,
              titleStyle: Theme.of(context).textTheme.bodyLarge,
              description: widget.realEstate.address!,
            ),
          ],
          TextItemWidget(
            minTitleWidth: 70,
            crossAxisAlignment: CrossAxisAlignment.start,
            title: context.translation.floor,
            titleStyle: Theme.of(context).textTheme.bodyLarge,
            description: widget.realEstate.floor.toString(),
          ),

          TextItemWidget(
            minTitleWidth: 70,
            crossAxisAlignment: CrossAxisAlignment.start,
            title: context.translation.bathrooms,
            titleStyle: Theme.of(context).textTheme.bodyLarge,
            description: widget.realEstate.bathrooms.toString(),
          ),
          TextItemWidget(
            minTitleWidth: 70,
            crossAxisAlignment: CrossAxisAlignment.start,
            title: context.translation.area,
            titleStyle: Theme.of(context).textTheme.bodyLarge,
            description: "${widget.realEstate.size} ${context.translation.m2}",
          ),
          TextItemWidget(
            minTitleWidth: 70,
            crossAxisAlignment: CrossAxisAlignment.start,
            title: context.translation.propertyType,
            titleStyle: Theme.of(context).textTheme.bodyLarge,
            description: context.translation.propertyTypeE(
              widget.realEstate.propertyType.name,
            ),
          ),
          if (widget.realEstate.propertyAge != null) ...[
            TextItemWidget(
              minTitleWidth: 70,
              crossAxisAlignment: CrossAxisAlignment.start,
              title: context.translation.age,
              titleStyle: Theme.of(context).textTheme.bodyLarge,
              description:
                  "${widget.realEstate.propertyAge} ${context.translation.year}",
            ),
          ],
        ],
      ),
    );
  }
}
