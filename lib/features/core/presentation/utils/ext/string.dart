import 'package:real_state/features/core/presentation/utils/file_manager.dart';
import 'package:real_state/injection.dart';

extension Util on String {
  String get addLeadingTimeZero {
    if (length == 1) {
      return '0$this';
    }
    return this;
  }

  String? get getUrl {
    return getIt<FileManager>().getFile(name: this);
  }
}
