import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_state/features/core/presentation/cubit/base_states/base_paginated_list_state.dart';

abstract class PaginationCubit<T, Params>
    extends Cubit<BasePaginatedListState<T>> {
  PaginationCubit(super.initialState);

  void get({Params? params});

  void paginate();
}
