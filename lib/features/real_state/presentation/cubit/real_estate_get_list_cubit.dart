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
    params.skip = 0;
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
    if (state.totalRecords == null) {
      return;
    }
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

  void removeItem(String id) {
    var k = state.items.where((e) => e.id != id).toList();
    emit(
      state.copyWith(
        items: k,
        totalRecords: state.totalRecords! - 1,
        hasReachedMax: k.length >= state.totalRecords! - 1,
      ),
    );
  }

  void setItem(RealEstate realEstate) {
    var k = state.items;
    for (int i = 0; i < k.length; i++) {
      if (k[i].id == realEstate.id) {
        k[i] = realEstate;
        break;
      }
    }
    emit(state.copyWith(items: k));
  }

  @override
  void paginate() async {
    emit(state.copyWith(status: PaginatedListStatus.paginateInProgress));
    int t = params.skip ?? 0;
    params.skip = state.items.length;
    var res = await repository.getRealEstates(params: params);
    res.fold(
      (e) {
        params.skip = t;
        emit(
          state.copyWith(
            status: PaginatedListStatus.paginateFailure,
            failure: e,
          ),
        );
      },
      (r) {
        var list = [...state.items, ...r.data];
        emit(
          state.copyWith(
            status: PaginatedListStatus.success,
            totalRecords: r.totalRecords,
            hasReachedMax: list.length >= r.totalRecords,
            items: list,
          ),
        );
      },
    );
  }
}
