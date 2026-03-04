import 'package:core_package/core_package.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/properties/domain/repository/property_repository.dart';

@injectable
class PropertyDeleteCubit extends Cubit<BaseState> {
  PropertiesRepository repository;

  PropertyDeleteCubit(this.repository) : super(BaseState());

  void delete(String id) async {
    emit(state.setInProgressState());
    var res = await repository.delete(id);
    res.fold(
      (e) => emit(state.setFailureState(e)),
      (r) => emit(state.setSuccessState(null)),
    );
  }
}
