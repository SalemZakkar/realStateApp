import 'dart:async';

import 'package:core_package/core_package.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/properties/domain/entity/property.dart';
import 'package:real_state/features/properties/domain/params/property_get_params.dart';
import 'package:real_state/features/properties/domain/repository/property_repository.dart';

@injectable
class PropertiesGetListCubit
    extends PaginationCubit<Property, PropertyGetParams> {
  PropertiesGetListCubit(this.repository) : super(BasePaginatedListState()) {
    streamSubscription = repository.newPropertyStream.listen((v) {
      int index = state.items.indexWhere((e) => e.id == v.id);
      if (index != -1) {
        if (params.owner != null && v.owner.id != params.owner) {
          return;
        }
        state.items[index] = v;
        emit(state.copyWith(items: state.items));
      } else {
        emit(state.copyWith(items: [v, ...state.items]));
      }
    });
    streamSubscription2 = repository.deletedPropertyStream.listen((v) {
      int index = state.items.indexWhere((e) => e.id == v);
      if (index > -1) {
        emit(
          state.copyWith(items: state.items.where((e) => e.id != v).toList()),
        );
      }
    });
    streamSubscription3 = repository.saveStream.listen((v) {
      int index = state.items.indexWhere((e) => e.id == v);
      if (index > -1) {
        state.items[index].isSaved = !state.items[index].isSaved;
        emit(state.copyWith(items: state.items));
      }
    });
  }

  PropertiesRepository repository;

  late PropertyGetParams params;

  StreamSubscription? streamSubscription;
  StreamSubscription? streamSubscription2;
  StreamSubscription? streamSubscription3;

  @override
  void get({PropertyGetParams? params}) async {
    this.params = params!;
    params.skip = 0;
    emit(state.setInProgressState());
    var res = await repository.getProperties(params);
    res.fold((e) => emit(state.setFailureState(e)), (r) {
      emit(
        state.setSuccessState(
          r.data,
          hasReachedEnd: r.hasReachedEnd,
          totalRecords: r.totalRecords,
        ),
      );
    });
  }

  @override
  void paginate() async {
    emit(state.copyWith(status: PaginatedListStatus.paginateInProgress));
    if (params.isSaved != null) {
      params.skip = state.items
          .where((e) => e.isSaved == params.isSaved)
          .length;
    } else {
      params.skip = state.items.length;
    }
    var res = await repository.getProperties(params);
    res.fold(
      (e) {
        emit(state.setFailureState(e));
      },
      (r) {
        var list = [...state.items, ...r.data];
        emit(
          state.setSuccessState(
            list,
            hasReachedEnd: r.hasReachedEnd,
            totalRecords: r.totalRecords,
          ),
        );
      },
    );
  }

  @override
  Future<void> close() async {
    await streamSubscription?.cancel();
    await streamSubscription2?.cancel();
    await streamSubscription3?.cancel();
    return super.close();
  }
}
