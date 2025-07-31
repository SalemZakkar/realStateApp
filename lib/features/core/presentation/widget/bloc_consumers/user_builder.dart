import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_state/features/auth/presentation/cubits/auth_cubit.dart';

import '../../../../../injection.dart';
import '../../../../user/domain/entity/user.dart';

class UserBuilder extends StatefulWidget {
  final Widget Function(BuildContext context, User user) builder;
  final void Function(User user)? onInit;
  final Widget? unAuthWidget;

  const UserBuilder({
    super.key,
    required this.builder,
    this.onInit,
    this.unAuthWidget,
  });

  @override
  State<UserBuilder> createState() => _UserBuilderState();
}

class _UserBuilderState extends State<UserBuilder> {
  @override
  void initState() {
    super.initState();
    if (getIt<AuthCubit>().state.authenticated) {
      WidgetsBinding.instance.addPostFrameCallback((e) {
        widget.onInit?.call((getIt<AuthCubit>().state).user);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state.authenticated) {
          return widget.builder.call(context, state.user);
        }

        return widget.unAuthWidget ?? const SizedBox();
      },
    );
  }
}
