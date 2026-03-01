import 'package:core_package/core_package.dart';
import 'package:injectable/injectable.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:real_state/features/core/domain/entity/errors.dart';

@injectable
class VideoCubit extends Cubit<BaseState<VideoController>> {
  VideoController? controller;
  Player? player;

  VideoCubit() : super(BaseState());

  void get(String url) async {
    try {
      emit(state.setInProgressState());
      player?.dispose();
      player = Player();
      controller = VideoController(player!);
      await player!.open(Media(url));
      emit(state.setSuccessState(controller!));
    } catch (e) {
      emit(
        state.setFailureState(InternalError(message: "خطأ في تجهيز الفيديو")),
      );
    }
  }

  @override
  Future<void> close() {
    player?.dispose();
    return super.close();
  }
}
