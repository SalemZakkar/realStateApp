import 'package:core_package/core_package.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/properties/domain/entity/property.dart';
import 'package:real_state/features/properties/domain/params/property_get_params.dart';
import 'package:real_state/features/properties/domain/repository/property_repository.dart';

@injectable
class PropertiesGetListCubit
    extends PaginationCubit<Property, PropertyGetParams> {
  PropertiesGetListCubit(this.repository) : super(BasePaginatedListState());
  PropertiesRepository repository;

  late PropertyGetParams params;

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
    params.skip = state.items.length;
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
}
