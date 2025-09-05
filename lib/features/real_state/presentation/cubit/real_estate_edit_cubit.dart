import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/core/presentation/cubit/base_states/base_state.dart';
import 'package:real_state/features/real_state/domain/entity/real_estate.dart';
import 'package:real_state/features/real_state/domain/params/real_estate_params.dart';
import 'package:real_state/features/real_state/domain/repository/real_estate_repository.dart';
import 'package:real_state/features/real_state/presentation/cubit/real_estate_details_cubit.dart';
import 'package:real_state/features/real_state/presentation/cubit/real_estate_get_list_cubit.dart';
import 'package:real_state/features/real_state/presentation/cubit/real_estate_get_mine_list_cubit.dart';
import 'package:real_state/injection.dart';

@injectable
class RealEstateEditCubit extends Cubit<BaseState<RealEstate>> {
  RealEstateEditCubit(this.repository) : super(BaseState());

  RealEstateRepository repository;

  void edit({required RealEstateParams params}) async {
    emit(state.setInProgressState());
    var res = await repository.edit(params: params);
    res.fold((e) => emit(state.setFailureState(e)), (r) {
      getIt<RealEstateGetListCubit>().setItem(r);
      getIt<RealEstateGetMineListCubit>().setItem(r);
      getIt<RealEstateDetailsCubit>().run(r);
      emit(state.setSuccessState(r));
    });
  }
}
