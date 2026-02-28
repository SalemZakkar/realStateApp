import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:real_state/features/core/domain/entity/city.dart';
import 'package:real_state/features/core/presentation/cubit/city_cubit.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/injection.dart';

class CityFilterDialog extends StatefulWidget {
  final String? city;
  final ValueChanged<City?> onSelected;

  const CityFilterDialog({super.key, this.city, required this.onSelected});

  @override
  State<CityFilterDialog> createState() => _CityFilterDialogState();
}

class _CityFilterDialogState extends State<CityFilterDialog> {
  var cubit = getIt<CityCubit>()..start();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.translation.city),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 420,
        child: ConsumerWidget(
          cubit: cubit,
          autoDispose: false,
          childBuilder: (context, state) {
            return Scrollbar(
              thumbVisibility: true,
              child: ListView.builder(
                itemCount: state.length + 1,
                itemBuilder: (context, index) {
                  if(index == 0){
                    return ListTile(
                      onTap: () {
                        widget.onSelected(null);
                        context.pop();
                      },
                      leading: Icon(
                        widget.city == null
                            ? Icons.radio_button_checked_rounded
                            : Icons.radio_button_off,
                        color: Theme.of(context).primaryColor,
                      ),
                      title: Text(context.translation.all),
                    );
                  }
                  return ListTile(
                    onTap: () {
                      widget.onSelected(state[index-1]);
                      context.pop();
                    },
                    leading: Icon(
                      widget.city == state[index-1].id
                          ? Icons.radio_button_checked_rounded
                          : Icons.radio_button_off,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text(state[index-1].name),
                  );
                },
              ),
            );
          },
          onRetry: cubit.start,
        ),
      ),
    );
  }
}
