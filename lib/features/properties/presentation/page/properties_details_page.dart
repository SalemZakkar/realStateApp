import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/widget/bloc_consumers/user_builder.dart';
import 'package:real_state/features/properties/presentation/cubits/properties_details_cubit.dart';
import 'package:real_state/features/properties/presentation/widget/property_view_widget.dart';
import 'package:real_state/injection.dart';

class PropertyDetailsPage extends StatefulWidget {
  static const String path = '/real-estate-details';
  final String id;

  const PropertyDetailsPage({super.key, required this.id});

  @override
  State<PropertyDetailsPage> createState() => _PropertyDetailsPageState();
}

class _PropertyDetailsPageState extends State<PropertyDetailsPage> {
  var cubit = getIt<PropertiesDetailsCubit>();

  @override
  void initState() {
    super.initState();
    cubit.get(widget.id);
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
                if (user.id == state.owner.id) {
                  return PropertyViewWidget(realEstate: state);
                }
                return PropertyViewWidget(realEstate: state);
              },
              unAuthWidget: PropertyViewWidget(realEstate: state),
            ),
          );
        },
        onRetry: () {
          cubit.get(widget.id);
        },
      ),
    );
  }
}
