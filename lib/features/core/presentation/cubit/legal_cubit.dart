import 'package:core_package/core_package.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/core/domain/entity/legal.dart';
import 'package:real_state/features/core/domain/repository/core_repository.dart';

@injectable
class LegalCubit extends Cubit<BaseState<Legal>> {
  LegalCubit(this.coreRepository) : super(BaseState());

  CoreRepository coreRepository;

  void get() async {
    emit(state.setInProgressState());
    var res = await coreRepository.getLegals();
    res.fold(
      (e) => emit(state.setFailureState(e)),
      (r) => emit(state.setSuccessState(r)),
    );
  }
}
