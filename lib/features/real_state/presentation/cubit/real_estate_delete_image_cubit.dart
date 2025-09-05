import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/core/presentation/cubit/base_states/base_state.dart';
import 'package:real_state/features/real_state/domain/repository/real_estate_repository.dart';

@injectable
class RealEstateDeleteImageCubit extends Cubit<BaseState<void>> {
  RealEstateDeleteImageCubit(this.repository) : super(BaseState());

  RealEstateRepository repository;

  void delete({required String id}) async {
    emit(state.setInProgressState());
    var res = await repository.deleteImage(image: id);
    res.fold(
      (e) => emit(state.setFailureState(e)),
      (r) => emit(state.setSuccessState(r)),
    );
  }
}
