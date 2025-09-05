// import 'package:file_picker/file_picker.dart';
// import 'dart:developer';

import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
// import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart' hide PickedFile;

import '../../domain/entity/picked_file.dart' show PickFile;

class FilePickUtil {
  static Future<PickFile?> getFile({
    List<String> ext = const [],
    FileType? type,
  }) async {
    final v = await FilePicker.platform.pickFiles(
      type: type ?? FileType.custom,
      allowedExtensions: ext,
      withData: true,
    );
    if (v?.files.firstOrNull?.bytes == null) {
      return null;
    }
    return PickFile(
      bytes: v!.files.firstOrNull!.bytes!,
      size: v.files.first.size,
      name: v.files.first.name,
      type: PickFile.getMime(v.files.first.name.split('.').last),
    );
  }

  static Future<PickFile?> getImage({
    required ImageSource source,
    double? maxWidth,
    int? compress,
  }) async {
    final v = await ImagePicker().pickImage(
      source: source,
      maxWidth: maxWidth ?? 1024,
      imageQuality: compress,
    );
    if (v != null) {
      Uint8List bytes = await v.readAsBytes();
      log('KB: ${bytes.lengthInBytes / 1024}');
      return PickFile(
        bytes: bytes,
        size: bytes.lengthInBytes,
        name: v.name,
        type: PickFile.getMime(v.name.split('.').last),
      );
    }
    return null;
  }
}
