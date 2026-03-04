import 'package:core_package/core_package.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/properties/domain/entity/property.dart';
import 'package:real_state/features/properties/domain/params/property_create_params.dart';
import 'package:real_state/features/properties/domain/repository/property_repository.dart';

@injectable
class PropertyAddEditCubit extends Cubit<BaseState<Property>> {
  PropertiesRepository repository;

  PropertyAddEditCubit(this.repository) : super(BaseState());

  void add(PropertyAddEditParams params) async {
    emit(state.setInProgressState());
    var res = await repository.create(params);
    res.fold(
      (e) => emit(state.setFailureState(e)),
      (r) => emit(state.setSuccessState(r)),
    );
  }

  void edit(String id, PropertyAddEditParams params) async {
    emit(state.setInProgressState());
    var res = await repository.edit(id, params);
    res.fold(
      (e) => emit(state.setFailureState(e)),
      (r) => emit(state.setSuccessState(r)),
    );
  }
}
