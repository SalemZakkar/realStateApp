import 'package:core_package/core_package.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/properties/domain/entity/property.dart';
import 'package:real_state/features/properties/domain/repository/property_repository.dart';

@injectable
class PropertiesDetailsCubit extends Cubit<BaseState<Property>> {
  PropertiesRepository repository;

  PropertiesDetailsCubit(this.repository) : super(BaseState());

  void get(String id) async {
    emit(state.setInProgressState());
    var res = await repository.getById(id);
    res.fold(
      (e) => emit(state.setFailureState(e)),
      (r) => emit(state.setSuccessState(r)),
    );
  }
}
