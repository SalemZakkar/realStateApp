import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_state/features/core/presentation/cubit/base_states/base_state.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/themes/app_theme.dart';

class DropDownBlocWidget<T> extends StatefulWidget {
  final BlocBase<BaseState<List<T>>> bloc;
  final bool autoDispose;
  final String hint;
  final ValueChanged<T> onChanged;
  final String Function(T) getValue;
  final VoidCallback callBloc;
  final bool required;
  final T? value;

  const DropDownBlocWidget({
    super.key,
    required this.bloc,
    this.autoDispose = true,
    required this.onChanged,
    required this.hint,
    required this.getValue,
    required this.callBloc,
    this.required = false,
    this.value,
  });

  @override
  State<DropDownBlocWidget<T>> createState() => _DropDownBlocWidgetState<T>();
}

class _DropDownBlocWidgetState<T> extends State<DropDownBlocWidget<T>> {
  @override
  void initState() {
    super.initState();
    widget.callBloc();
    value = widget.value;
  }

  T? value;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocBase<BaseState<List<T>>>, BaseState<List<T>>>(
      bloc: widget.bloc,
      builder: (context, state) {
        return DropdownButtonFormField<T>(
          decoration: InputDecoration(
            suffixIcon: state.isFailure
                ? IconButton(
                    onPressed: widget.callBloc,
                    icon: Icon(
                      Icons.refresh,
                      color: context.appColorSchema.statusColors.fail,
                    ),
                  )
                : state.isInProgress
                ? CircularProgressIndicator(
                    constraints: BoxConstraints(maxWidth: 4, maxHeight: 4),
                  )
                : null,
          ),
          validator: (c) {
            if ((value == null && widget.required) ||
                (!state.isSuccess && widget.required)) {
              return context.translation.fieldRequiredMessage;
            }
            return null;
          },
          hint: Text(
            state.isFailure ? state.failure!.getError(context) : widget.hint,
          ),
          initialValue: value,
          items: (state.item ?? [])
              .map(
                (e) => DropdownMenuItem<T>(
                  value: e,
                  child: Text(widget.getValue(e)),
                ),
              )
              .toList(),
          onChanged: state.isSuccess
              ? (v) {
                  if (v != null) {
                    value = v;
                    widget.onChanged(v);
                  }
                }
              : null,
        );
      },
    );
  }
}
