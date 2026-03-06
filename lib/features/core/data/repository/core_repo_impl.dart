import 'dart:async';
import 'dart:io';
import 'package:core_package/core_package.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/core/data/model/about_us_model/about_us_model.dart';
import 'package:real_state/features/core/data/source/core_remote_source/core_remote_source.dart';
import 'package:real_state/features/core/data/utils/api_handler.dart';
import 'package:real_state/features/core/domain/entity/about_us.dart';
import 'package:real_state/features/core/domain/entity/city.dart';
import 'package:real_state/features/core/domain/entity/errors.dart';
import 'package:real_state/features/core/domain/repository/core_repository.dart';
import 'package:v_video_compressor/v_video_compressor.dart';

@Singleton(as: CoreRepository)
class CoreRepoImpl extends CoreRepository with ApiHandler {
  CoreRemoteSource source;

  CoreRepoImpl(this.source);

  @override
  Future<Either<Failure, List<City>>> getCities() {
    return request(() async {
      var res = await source.getCities();
      return Right(res.data!.map((e) => e.toDomain()).toList());
    });
  }

  @override
  Future<Either<Failure, AboutUs>> getAboutUs() async {
    return request(() async {
      var res = await source.getAboutUs();
      return Right(res.data!.toDomain());
    });
  }

  @override
  Future<Either<Failure, String>> getVideoThumbnail(String url) {
    var dio = Dio(
      BaseOptions(
        responseType: ResponseType.bytes,
        headers: {"Range": "0-614400"},
      ),
    );
    return request(() async {
      var filename = "${url.split("/").last}.png";
      var dir = "${(await getApplicationCacheDirectory()).path}/thumbnails";
      if (!(await Directory(dir).exists())) {
        await Directory(dir).create(recursive: true);
      }
      var bytes = await dio.get(url);
      var comp = VVideoCompressor();
      await File("$dir/$filename").writeAsBytes(bytes.data);
      var thumbnail = await comp.getVideoThumbnail(
        "$dir/$filename",
        VVideoThumbnailConfig(timeMs: 5000),
      );
      if (thumbnail == null) {
        throw InternalError();
      }

      return Right(thumbnail.thumbnailPath);
    });
  }
}
