import 'package:core_package/core_package.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/properties/domain/entity/property.dart';
import 'package:real_state/features/properties/domain/params/property_get_params.dart';
import 'package:real_state/features/properties/domain/params/property_map_params.dart';
import 'package:real_state/features/properties/domain/repository/property_repository.dart';

@injectable
class PropertyMapCubit extends Cubit<BaseState<List<Property>>> {
  PropertiesRepository repository;

  PropertyMapCubit(this.repository) : super(BaseState());

  void get(PropertyMapParams params) async {
    emit(state.setInProgressState());
    var res = await repository.getMap(params);
    res.fold(
      (e) => emit(state.setFailureState(e)),
      (r) => emit(state.setSuccessState(r)),
    );
  }
}
