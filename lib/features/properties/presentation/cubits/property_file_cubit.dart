import 'package:core_package/core_package.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/properties/domain/entity/property.dart';
import 'package:real_state/features/properties/domain/repository/property_repository.dart';

@injectable
class PropertyFileCubit extends Cubit<BaseState<Property>> {
  PropertiesRepository repository;

  PropertyFileCubit(this.repository) : super(BaseState());

  void addImage(String id, PickFile image) async {
    emit(state.setInProgressState());
    var res = await repository.addImage(id, image);
    res.fold(
      (e) => emit(state.setFailureState(e)),
      (r) => emit(state.setSuccessState(r)),
    );
  }

  void deleteImage(String id, String image) async {
    emit(state.setInProgressState());
    var res = await repository.deleteImage(id, image);
    res.fold(
      (e) => emit(state.setFailureState(e)),
      (r) => emit(state.setSuccessState(r)),
    );
  }

  void deleteVideo(String id, String video) async {
    emit(state.setInProgressState());
    var res = await repository.deleteImage(id, video);
    res.fold(
      (e) => emit(state.setFailureState(e)),
      (r) => emit(state.setSuccessState(r)),
    );
  }
}
