import 'package:core_package/core_package.dart';
import 'package:v_video_compressor/v_video_compressor.dart';

class CompressVideoState {
  double? progress;
  bool? fail;
  String? path;

  CompressVideoState({this.fail, this.progress, this.path});
}

class CompressVideoCubit extends Cubit<CompressVideoState> {
  CompressVideoCubit() : super(CompressVideoState());
  VVideoCompressor compressor = VVideoCompressor();

  void compress(String path) async {
    emit(CompressVideoState());
    try {
      var res = await compressor.compressVideo(
        path,
        VVideoCompressionConfig(
          quality: VVideoCompressQuality.medium,
          useFastStart: true,
          // copyMetadata: false,
          advanced: VVideoAdvancedConfig(
          ),
          optimizeForStreaming: true,
          // advanced: VVideoAdvancedConfig.socialMediaOptimized(),
        ),
        onProgress: (v) {
          emit(CompressVideoState(progress: v));
        },
      );
      if (res != null) {
        emit(CompressVideoState(path: res.compressedFilePath));
        return;
      }
      throw Exception();
    } catch (e) {
      emit(CompressVideoState(fail: true));
    }
  }

  @override
  Future<void> close() async {
    if (await compressor.isCompressing()) {
      compressor.cancelCompression();
    }
    compressor.cleanup();
    return super.close();
  }
}
