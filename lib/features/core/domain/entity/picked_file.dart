import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart';

class PickFile {
  final Uint8List bytes;
  final int size;
  final String name;
  final String type;

  PickFile({
    required this.size,
    required this.name,
    required this.type,
    required this.bytes,
  });

  MultipartFile get multipartFile {
    return MultipartFile.fromBytes(
      bytes,
      filename: name,
      contentType: MediaType.parse(type),
    );
  }

  static String getMime(String ext, {String fallBack = "image/png"}) {
    Map<String, String> types = {
      // Images
      'png': 'image/png',
      'jpg': 'image/jpeg',
      'jpeg': 'image/jpeg',
      'gif': 'image/gif',
      'webp': 'image/webp',
      'bmp': 'image/bmp',
      'tif': 'image/tiff',
      'tiff': 'image/tiff',
      'svg': 'image/svg+xml',
      'ico': 'image/x-icon',

      // Documents
      'pdf': 'application/pdf',
      'doc': 'application/msword',
      'docx':
          'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
      'xls': 'application/vnd.ms-excel',
      'xlsx':
          'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
      'ppt': 'application/vnd.ms-powerpoint',
      'pptx':
          'application/vnd.openxmlformats-officedocument.presentationml.presentation',
      'odt': 'application/vnd.oasis.opendocument.text',
      'ods': 'application/vnd.oasis.opendocument.spreadsheet',
      'odp': 'application/vnd.oasis.opendocument.presentation',
      'rtf': 'application/rtf',
      'txt': 'text/plain',
      'md': 'text/markdown',
      'csv': 'text/csv',

      // Audio
      'mp3': 'audio/mpeg',
      'wav': 'audio/wav',
      'ogg': 'audio/ogg',
      'm4a': 'audio/mp4',
      'flac': 'audio/flac',
      'aac': 'audio/aac',

      // Video
      'mp4': 'video/mp4',
      'webm': 'video/webm',
      'ogv': 'video/ogg',
      'mov': 'video/quicktime',
      'avi': 'video/x-msvideo',
      'mkv': 'video/x-matroska',
      'wmv': 'video/x-ms-wmv',

      // Archives
      'zip': 'application/zip',
      'tar': 'application/x-tar',
      'gz': 'application/gzip',
      'bz2': 'application/x-bzip2',
      '7z': 'application/x-7z-compressed',
      'rar': 'application/vnd.rar',

      // Web / Code
      'html': 'text/html',
      'htm': 'text/html',
      'css': 'text/css',
      'js': 'application/javascript',
      'json': 'application/json',
      'xml': 'application/xml',
      'wasm': 'application/wasm',
    };
    return types[ext] ?? fallBack;
  }
}
