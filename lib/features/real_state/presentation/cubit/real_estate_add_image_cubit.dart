import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/core/domain/entity/picked_file.dart';
import 'package:real_state/features/core/presentation/cubit/base_states/base_state.dart';
import 'package:real_state/features/real_state/domain/entity/real_estate.dart';
import 'package:real_state/features/real_state/domain/repository/real_estate_repository.dart';

@injectable
class RealEstateAddImageCubit extends Cubit<BaseState<RealEstate>> {
  RealEstateAddImageCubit(this.repository) : super(BaseState());

  RealEstateRepository repository;

  void add({required PickFile file, required String id}) async {
    emit(state.setInProgressState());
    var res = await repository.addImage(id: id, file: file);
    res.fold(
      (e) => emit(state.setFailureState(e)),
      (r) => emit(state.setSuccessState(r)),
    );
  }
}
