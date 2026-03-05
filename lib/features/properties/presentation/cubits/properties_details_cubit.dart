import 'dart:async';

import 'package:core_package/core_package.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/properties/domain/entity/property.dart';
import 'package:real_state/features/properties/domain/repository/property_repository.dart';

@injectable
class PropertiesDetailsCubit extends Cubit<BaseState<Property>> {
  PropertiesRepository repository;

  PropertiesDetailsCubit(this.repository) : super(BaseState()) {
    streamSubscription = repository.newPropertyStream.listen((v) {
      if (v.id == state.item?.id) {
        emit(state.setSuccessState(v));
      }
    });
    streamSubscription2 = repository.saveStream.listen((v) {
      if (state.item?.id == v) {
        var prop = state.item;
        if (prop!.isSaved) {
          prop.isSaved = true;
        } else {
          prop.isSaved = false;
        }
        emit(state.setSuccessState(prop));
      }
    });
  }

  StreamSubscription? streamSubscription;
  StreamSubscription? streamSubscription2;

  void get(String id) async {
    emit(state.setInProgressState());
    var res = await repository.getById(id);
    res.fold(
      (e) => emit(state.setFailureState(e)),
      (r) => emit(state.setSuccessState(r)),
    );
  }

  @override
  Future<void> close() async {
    await streamSubscription?.cancel();
    await streamSubscription2?.cancel();
    return super.close();
  }
}
