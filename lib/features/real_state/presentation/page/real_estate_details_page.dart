import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/widget/bloc_consumers/user_builder.dart';
import 'package:real_state/features/real_state/domain/entity/real_estate.dart';
import 'package:real_state/features/real_state/presentation/widget/real_estate_view_user_widget.dart';
import 'package:real_state/features/real_state/presentation/widget/real_estate_view_widget.dart';

class RealEstateDetailsPage extends StatefulWidget {
  static const String path = '/real-estate-details';
  final RealEstate realEstate;

  const RealEstateDetailsPage({super.key, required this.realEstate});

  @override
  State<RealEstateDetailsPage> createState() => _RealEstateDetailsPageState();
}

class _RealEstateDetailsPageState extends State<RealEstateDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: UserBuilder(
          builder: (context, user) {
            if (user.id == widget.realEstate.owner) {
              return RealEstateViewUserWidget(realEstate: widget.realEstate);
            }
            return RealEstateViewWidget(realEstate: widget.realEstate);
          },
          unAuthWidget: RealEstateViewWidget(realEstate: widget.realEstate),
        ),
      ),
    );
  }
}
