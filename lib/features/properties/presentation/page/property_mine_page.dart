import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/bloc_consumers/user_builder.dart';
import 'package:real_state/features/properties/domain/params/property_get_params.dart';
import 'package:real_state/features/properties/presentation/widget/mine/property_mine_card_widget.dart';
import 'package:real_state/features/properties/presentation/widget/property_list_widget.dart';

class PropertyMinePage extends StatefulWidget {
  static String path = "/PropertyMinePage";

  const PropertyMinePage({super.key});

  @override
  State<PropertyMinePage> createState() => _PropertyMinePageState();
}

class _PropertyMinePageState extends State<PropertyMinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UserBuilder(
        builder: (context, user) {
          return Container(
            constraints: const BoxConstraints.expand(),
            child: PropertyListWidget(
              withFilter: false,
              title: context.translation.myProperties,
              params: PropertyGetParams(skip: 0, limit: 10, owner: user.id),
              builder: (data) {
                return Column(
                  children: [
                    PropertyMineCardWidget(property: data),
                    8.height(),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
