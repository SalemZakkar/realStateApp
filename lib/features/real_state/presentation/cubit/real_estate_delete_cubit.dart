import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/core/presentation/cubit/base_states/base_state.dart';
import 'package:real_state/features/real_state/domain/repository/real_estate_repository.dart';
import 'package:real_state/features/real_state/presentation/cubit/real_estate_get_list_cubit.dart';
import 'package:real_state/features/real_state/presentation/cubit/real_estate_get_mine_list_cubit.dart';
import 'package:real_state/injection.dart';

@injectable
class RealEstateDeleteCubit extends Cubit<BaseState<void>> {
  RealEstateDeleteCubit(this.repository) : super(BaseState());

  RealEstateRepository repository;

  void delete({required String id}) async {
    emit(state.setInProgressState());
    var res = await repository.delete(id: id);
    res.fold((e) => emit(state.setFailureState(e)), (r) {
      getIt<RealEstateGetListCubit>().removeItem(id);
      getIt<RealEstateGetMineListCubit>().removeItem(id);
      emit(state.setSuccessState(r));
    });
  }
}
