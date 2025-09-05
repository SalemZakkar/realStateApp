import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/core/presentation/cubit/base_states/base_state.dart';
import 'package:real_state/features/real_state/domain/entity/real_estate.dart';
import 'package:real_state/features/real_state/domain/params/real_estate_params.dart';
import 'package:real_state/features/real_state/domain/repository/real_estate_repository.dart';

@injectable
class RealEstateCreateCubit extends Cubit<BaseState<RealEstate>> {
  RealEstateCreateCubit(this.repository) : super(BaseState());

  RealEstateRepository repository;

  void add({required RealEstateParams params}) async {
    emit(state.setInProgressState());
    var res = await repository.create(params: params);
    res.fold(
      (e) => emit(state.setFailureState(e)),
      (r) => emit(state.setSuccessState(r)),
    );
  }
}
