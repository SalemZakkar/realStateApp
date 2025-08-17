import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_state/features/core/presentation/cubit/base_states/base_state.dart';
import 'package:real_state/features/core/presentation/widget/bloc_consumers/consumer_widget.dart';
import 'package:real_state/features/real_state/domain/entity/real_estate.dart';
import 'package:real_state/features/real_state/presentation/cubit/real_estate_map_get.dart';

class RealEstateMapBlocWidget extends StatefulWidget {
  final RealEstateMapGetCubit cubit;
  final ValueChanged<List<RealEstate>> onSuccess;

  const RealEstateMapBlocWidget({
    super.key,
    required this.cubit,
    required this.onSuccess,
  });

  @override
  State<RealEstateMapBlocWidget> createState() =>
      _RealEstateMapBlocWidgetState();
}

class _RealEstateMapBlocWidgetState extends State<RealEstateMapBlocWidget> {
  bool k = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<RealEstateMapGetCubit, BaseState<List<RealEstate>>>(
      bloc: widget.cubit,
      listener: (context, state) {
        setState(() {
          k = !state.isSuccess;
        });
        if (state.isInProgress || state.isFailure) {
          widget.onSuccess([]);
        }
      },
      child: Visibility(
        visible: k,
        child: Container(
          constraints: BoxConstraints(minHeight: 100),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
          ),
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: ConsumerWidget(
              onDataReceived: (v) {
                widget.onSuccess(v);
              },
              autoDispose: false,
              cubit: widget.cubit,
              childBuilder: (context, items) => const SizedBox.shrink(),
              onRetry: () {
                // return widget.cubit
                widget.cubit.retry();
              },
            ),
          ),
        ),
      ),
    );
  }
}
