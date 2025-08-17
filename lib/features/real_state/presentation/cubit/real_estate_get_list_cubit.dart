import 'package:injectable/injectable.dart';
import 'package:real_state/features/core/presentation/cubit/base_states/base_paginated_list_state.dart';
import 'package:real_state/features/core/presentation/cubit/pagination_cubit.dart';
import 'package:real_state/features/real_state/domain/entity/real_estate.dart';
import 'package:real_state/features/real_state/domain/params/real_estate_get_params.dart';
import 'package:real_state/features/real_state/domain/repository/real_estate_repository.dart';

@singleton
class RealEstateGetListCubit
    extends PaginationCubit<RealEstate, RealEstateGetParams> {
  RealEstateGetListCubit(this.repository) : super(BasePaginatedListState());
  RealEstateRepository repository;

  late RealEstateGetParams params;

  @override
  void get({RealEstateGetParams? params}) async {
    this.params = params!;
    emit(state.setInProgressState());
    var res = await repository.getRealEstates(params: params);
    res.fold((e) => emit(state.setFailureState(e)), (r) {
      emit(
        state.copyWith(
          status: PaginatedListStatus.success,
          totalRecords: r.totalRecords,
          hasReachedMax: r.totalRecords == r.data.length,
          items: r.data,
        ),
      );
    });
  }

  void removeFavourite(String id) {
    if (params.isFavourite == true) {
      var res = state.items.where((e) => e.id != id).toList();
      emit(
        state.copyWith(
          items: res,
          totalRecords: state.totalRecords! - 1,
          hasReachedMax: res.length >= state.totalRecords! - 1,
        ),
      );
    }
  }

  @override
  void paginate() async {
    if (state.hasReachedMax ||
        state.isInProgress ||
        state.isPaginateInProgress) {
      return;
    }
    emit(state.copyWith(status: PaginatedListStatus.paginateInProgress));

    params.page = (params.page ?? 0) + 1;
    var res = await repository.getRealEstates(params: params);
    res.fold((e) => emit(state.setPaginateFailureState(e)), (r) {
      var list = [...state.items, ...r.data];
      emit(
        state.copyWith(
          status: PaginatedListStatus.success,
          totalRecords: r.totalRecords,
          hasReachedMax: list.length >= r.totalRecords,
          items: list,
        ),
      );
    });
  }
}
