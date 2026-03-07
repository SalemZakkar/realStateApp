import 'package:core_package/core_package.dart';
import 'package:real_state/features/core/domain/entity/errors.dart';
import 'package:v_video_compressor/v_video_compressor.dart';

class VideoThumbnailCubit extends Cubit<BaseState<String?>> {
  VideoThumbnailCubit() : super(BaseState());
  VVideoCompressor compressor = VVideoCompressor();

  void get(String path) async {
    emit(state.setInProgressState());
    try {
      var res = await compressor.getVideoThumbnail(
        path,
        VVideoThumbnailConfig(timeMs: 3000,),
      );
      emit(state.setSuccessState(res?.thumbnailPath));
    } catch (e) {
      emit(state.setFailureState(InternalError()));
    }
  }

  @override
  Future<void> close() {
    compressor.cleanup();
    return super.close();
  }
}
