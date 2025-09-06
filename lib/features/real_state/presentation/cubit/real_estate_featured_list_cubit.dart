import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/core/presentation/cubit/base_states/base_state.dart';
import 'package:real_state/features/real_state/domain/entity/real_estate.dart';
import 'package:real_state/features/real_state/domain/params/real_estate_get_params.dart';
import 'package:real_state/features/real_state/domain/repository/real_estate_repository.dart';

@injectable
class RealEstateFeaturedListCubit extends Cubit<BaseState<List<RealEstate>>> {
  RealEstateFeaturedListCubit(this.repository) : super(BaseState());
  RealEstateRepository repository;

  void get() async {
    emit(state.setInProgressState());
    var res = await repository.getRealEstates(
      params: RealEstateGetParams(skip: 0, limit: 10),
    );
    res.fold(
      (l) => emit(state.setFailureState(l)),
      (r) => emit(state.setSuccessState(r.data)),
    );
  }
}
