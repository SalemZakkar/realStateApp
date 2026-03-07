import 'dart:async';

import 'package:core_package/core_package.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/properties/domain/repository/property_repository.dart';

class PropertyUploadVideoState {
  bool wait;
  Failure? failure;
  double? progress;
  bool? compress;
  bool done;

  PropertyUploadVideoState({
    this.failure,
    this.progress,
    this.compress,
    this.wait = false,
    this.done = false,
  });
}

@injectable
class PropertyUploadVideoCubit extends Cubit<PropertyUploadVideoState> {
  PropertyUploadVideoCubit(this.propertiesRepository)
    : super(PropertyUploadVideoState());

  PropertiesRepository propertiesRepository;

  PickFile? pickFile;

  void upload(String id, String file) async {
    emit(PropertyUploadVideoState(wait: true));
    if (pickFile?.file.path != file) {
      pickFile = await PickFile.fromPath(file);
    }
    var res = await propertiesRepository.uploadVideo(
      id,
      await PickFile.fromPath(file),
      (a, b) {
        emit(PropertyUploadVideoState(wait: false, progress: a, compress: b));
      },
    );
    if (res.isRight()) {
      emit(PropertyUploadVideoState(wait: false, done: true));
    } else {
      emit(
        PropertyUploadVideoState(
          failure: res.asLeft(),
          done: false,
          wait: false,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    propertiesRepository.cleanCompressedCache();
    return super.close();
  }
}
