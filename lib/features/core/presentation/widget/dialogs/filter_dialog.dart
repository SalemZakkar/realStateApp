import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/cubit/city_cubit.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/injection.dart';

class FilterDialog<T> extends StatefulWidget {
  final T? selected;
  final ValueChanged<T?> onSelected;
  final String Function(T) getName;
  final List<T> data;
  final bool Function(T?, T?) equal;
  final String title;
  final double? height;

  const FilterDialog({
    super.key,
    this.selected,
    required this.onSelected,
    required this.data,
    required this.equal,
    required this.getName,
    required this.title,
    this.height,
  });

  @override
  State<FilterDialog<T>> createState() =>
      _FilterDialogState<T>();
}

class _FilterDialogState<T> extends State<FilterDialog<T>> {
  var cubit = getIt<CityCubit>()..start();

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(
        widget.selected == null
            ? widget.title
            : widget.getName(widget.selected as T),
      ),
      selected: widget.selected != null,
      onSelected: (v) {
        showDialog(
          context: context,
          builder: (context) => _D(
            onSelected: widget.onSelected,
            data: widget.data,
            equal: widget.equal,
            getName: widget.getName,
            title: widget.title,
            height: widget.height,
            selected: widget.selected,
          ),
        );
      },
    );
  }
}

class _D<T> extends StatefulWidget {
  final T? selected;
  final ValueChanged<T?> onSelected;
  final String Function(T) getName;
  final List<T> data;
  final bool Function(T?, T?) equal;
  final String title;
  final double? height;

  const _D({
    this.selected,
    required this.onSelected,
    required this.data,
    required this.equal,
    required this.getName,
    required this.title,
    this.height,
  });

  @override
  State<_D<T>> createState() => _DState<T>();
}

class _DState<T> extends State<_D<T>> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: widget.height ?? 420,
        child: Scrollbar(
          thumbVisibility: true,
          child: ListView.builder(
            itemCount: widget.data.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return ListTile(
                  onTap: () {
                    widget.onSelected(null);
                    context.pop();
                  },
                  leading: Icon(
                    widget.selected == null
                        ? Icons.radio_button_checked_rounded
                        : Icons.radio_button_off,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(context.translation.all),
                );
              }
              bool selected = widget.equal(
                widget.data[index - 1],
                widget.selected,
              );

              return ListTile(
                onTap: () {
                  widget.onSelected(widget.data[index - 1]);
                  context.pop();
                },
                leading: Icon(
                  selected
                      ? Icons.radio_button_checked_rounded
                      : Icons.radio_button_off,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text(widget.getName(widget.data[index - 1])),
              );
            },
          ),
        ),
      ),
    );
  }
}
