import 'package:core_package/core_package.dart';
import 'package:logger/logger.dart';
import 'package:real_state/features/core/domain/entities/errors.dart';

typedef FutureEitherFailureOrData<T> = Future<Either<Failure, T>> Function();

mixin ApiHandler {
  final Logger _logger = Logger();

  Future<Either<Failure, T>> request<T>(
    FutureEitherFailureOrData<T> body,
  ) async {
    try {
      return await body();
    } on DioException catch (e, stack) {
      _logger.e(e.toString(), error: e, stackTrace: stack);
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        return left(TimeOutError());
      } else if (e.type == DioExceptionType.badResponse) {
        return left(ServerError(null));
      } else {
        return left(NetworkError());
      }
    } catch (e, stack) {
      _logger.e(e.toString(), error: e, stackTrace: stack);
      return left(InternalError());
    }
  }
}
