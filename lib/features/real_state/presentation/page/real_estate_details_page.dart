import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/widget/bloc_consumers/consumer_widget.dart';
import 'package:real_state/features/core/presentation/widget/bloc_consumers/user_builder.dart';
import 'package:real_state/features/real_state/domain/entity/real_estate.dart';
import 'package:real_state/features/real_state/presentation/cubit/real_estate_details_cubit.dart';
import 'package:real_state/features/real_state/presentation/widget/real_estate_view_user_widget.dart';
import 'package:real_state/features/real_state/presentation/widget/real_estate_view_widget.dart';
import 'package:real_state/injection.dart';

class RealEstateDetailsPage extends StatefulWidget {
  static const String path = '/real-estate-details';
  final RealEstate realEstate;

  const RealEstateDetailsPage({super.key, required this.realEstate});

  @override
  State<RealEstateDetailsPage> createState() => _RealEstateDetailsPageState();
}

class _RealEstateDetailsPageState extends State<RealEstateDetailsPage> {
  var cubit = getIt<RealEstateDetailsCubit>();

  @override
  void initState() {
    super.initState();
    cubit.run(widget.realEstate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConsumerWidget(
        cubit: cubit,
        childBuilder: (context, state) {
          return Container(
            constraints: const BoxConstraints.expand(),
            child: UserBuilder(
              builder: (context, user) {
                if (user.id == widget.realEstate.owner) {
                  return RealEstateViewUserWidget(realEstate: state);
                }
                return RealEstateViewWidget(realEstate: state);
              },
              unAuthWidget: RealEstateViewWidget(realEstate: state),
            ),
          );
        },
        autoDispose: false,
        onRetry: () {},
      ),
    );
  }
}
