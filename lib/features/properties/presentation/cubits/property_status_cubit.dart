import 'package:core_package/core_package.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/properties/domain/entity/property.dart';
import 'package:real_state/features/properties/domain/enum/property_enum.dart';
import 'package:real_state/features/properties/domain/repository/property_repository.dart';

@injectable
class PropertyStatusCubit extends Cubit<BaseState<Property>> {
  PropertiesRepository repository;

  PropertyStatusCubit(this.repository) : super(BaseState());

  void changeStatus(String id, PropertyStatus status) async {
    emit(state.setInProgressState());
    var res = await repository.changeStatus(id, status);
    res.fold(
      (e) => emit(state.setFailureState(e)),
      (r) => emit(state.setSuccessState(r)),
    );
  }
}
