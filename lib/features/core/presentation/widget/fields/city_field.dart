import 'package:flutter/material.dart';
import 'package:real_state/features/core/domain/entity/city.dart';
import 'package:real_state/features/core/presentation/cubit/city_cubit.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/fields/drop_down_bloc_widget.dart';
import 'package:real_state/injection.dart';

class CityField extends StatefulWidget {
  final City? initial;
  final ValueChanged<City> onChanged;
  final bool required;

  const CityField({
    super.key,
    required this.onChanged,
    this.initial,
    this.required = false,
  });

  @override
  State<CityField> createState() => _CityFieldState();
}

class _CityFieldState extends State<CityField> {
  var cubit = getIt<CityCubit>();

  @override
  Widget build(BuildContext context) {
    return DropDownBlocWidget<City>(
      bloc: cubit,
      onChanged: widget.onChanged,
      autoDispose: false,
      required: widget.required,
      hint: context.translation.city,
      getValue: (v) => v.name,
      callBloc: () {
        cubit.start();
      },
    );
  }
}
