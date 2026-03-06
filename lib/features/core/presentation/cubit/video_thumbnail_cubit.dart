import 'package:core_package/core_package.dart';
import 'package:real_state/features/core/domain/entity/errors.dart';
import 'package:real_state/features/core/domain/repository/core_repository.dart';
import 'package:real_state/injection.dart';
import 'package:v_video_compressor/v_video_compressor.dart';

class VideoThumbnailCubit extends Cubit<BaseState<String?>> {
  VideoThumbnailCubit() : super(BaseState());
  VVideoCompressor compressor = VVideoCompressor();

  void get(String path) async {
    emit(state.setInProgressState());
    try {
      var res = await compressor.getVideoThumbnail(
        path,
        VVideoThumbnailConfig(timeMs: 6000, format: VThumbnailFormat.png),
      );
      emit(state.setSuccessState(res?.thumbnailPath));
    } catch (e) {
      emit(state.setFailureState(InternalError()));
    }
  }

  void getUrl(String url) async {
    emit(state.setInProgressState());
    var res = await getIt<CoreRepository>().getVideoThumbnail(url);
    res.fold(
      (e) => emit(state.setSuccessState(null)),
      (r) => emit(state.setSuccessState(r)),
    );
  }

  @override
  Future<void> close() {
    compressor.cleanup();
    return super.close();
  }
}
