import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/core/presentation/cubit/base_states/base_state.dart';
import 'package:real_state/features/real_state/domain/entity/real_estate.dart';
import 'package:real_state/features/real_state/domain/params/real_estate_map_get_params.dart';
import 'package:real_state/features/real_state/domain/repository/real_estate_repository.dart';

@injectable
class RealEstateMapGet extends Cubit<BaseState<List<RealEstate>>> {
  RealEstateMapGet(this.repository) : super(BaseState());

  RealEstateRepository repository;

  void get({required RealEstateMapGetParams params}) async {
    emit(state.setInProgressState());
    var res = await repository.getRealEstatesMap(params: params);
    res.fold(
      (e) => emit(state.setFailureState(e)),
      (r) => emit(state.setSuccessState(r)),
    );
  }
}
