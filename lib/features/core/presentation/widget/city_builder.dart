import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:real_state/features/core/domain/entity/city.dart';
import 'package:real_state/features/core/presentation/cubit/city_cubit.dart';
import 'package:real_state/injection.dart';

class CityBuilder extends StatefulWidget {
  final Widget Function(List<City>) builder;
  final ValueChanged<List<City>>? onInit;

  const CityBuilder({super.key, required this.builder, this.onInit});

  @override
  State<CityBuilder> createState() => _CityBuilderState();
}

class _CityBuilderState extends State<CityBuilder> {
  final cityCubit = getIt<CityCubit>()..start();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((e) {
      if (cityCubit.state.isSuccess) {
        widget.onInit?.call(cityCubit.state.item ?? []);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConsumerWidget(
      onDataReceived: (v) {
        widget.onInit?.call(v);
      },
      cubit: cityCubit,
      autoDispose: false,
      childBuilder: (context, state) {
        return widget.builder(state);
      },
      onRetry: () {
        cityCubit.start();
      },
    );
  }
}
