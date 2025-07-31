import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:math' as math;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

const _timeStampKey = '_pdl_timeStamp_';

class UnifiInterceptor extends Interceptor {
  final bool request;

  final bool requestHeader;

  final bool requestBody;

  final bool responseBody;

  final bool responseHeader;

  final bool error;

  static const int kInitialTab = 1;

  static const String tabStep = '    ';

  final bool compact = true;

  final int maxWidth = 90;

  static const int chunkSize = 20;

  final bool enabled;

  final bool usePrint;

  UnifiInterceptor({
    this.request = true,
    this.requestHeader = false,
    this.requestBody = false,
    this.responseHeader = false,
    this.responseBody = true,
    this.error = true,
    this.enabled = true,
    this.usePrint = false,
  });

  void logPrint(Object? object, PrintType printType) {
    String colorPointerStart = '', colorPointerEnd = '';
    if (printType == PrintType.error) {
      colorPointerStart = '\x1B[31m';
    }
    if (printType == PrintType.response) {
      colorPointerStart = '\x1B[36m';
    }
    if (printType == PrintType.request) {
      colorPointerStart = '\x1B[33m';
    }
    if (printType == PrintType.curl) {
      colorPointerStart = '\x1b[35m';
    }
    colorPointerEnd = '\x1B[0m';
    if (kDebugMode) {
      print(
          "$colorPointerStart${(object?.toString() ?? "null")}$colorPointerEnd");
    }
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final extra = Map.of(options.extra);
    options.extra[_timeStampKey] = DateTime.timestamp().millisecondsSinceEpoch;

    if (request) {
      _printRequestHeader(options);
    }
    if (requestHeader) {
      _printMapAsTable(options.queryParameters,
          header: 'Query Parameters', printType: PrintType.request);
      final requestHeaders = <String, dynamic>{};
      requestHeaders.addAll(options.headers);
      if (options.contentType != null) {
        requestHeaders['contentType'] = options.contentType?.toString();
      }
      requestHeaders['responseType'] = options.responseType.toString();
      requestHeaders['followRedirects'] = options.followRedirects;
      if (options.connectTimeout != null) {
        requestHeaders['connectTimeout'] = options.connectTimeout?.toString();
      }
      if (options.receiveTimeout != null) {
        requestHeaders['receiveTimeout'] = options.receiveTimeout?.toString();
      }
      _printMapAsTable(requestHeaders,
          header: 'Headers', printType: PrintType.request);
      _printMapAsTable(extra, header: 'Extras', printType: PrintType.request);
    }
    if (requestBody) {
      final dynamic data = options.data;
      if (data != null) {
        if (data is Map) {
          _printMapAsTable(options.data as Map?,
              header: 'Body', printType: PrintType.request);
        }
        if (data is FormData) {
          final formDataMap = <String, dynamic>{}
            ..addEntries(data.fields)
            ..addEntries(data.files);
          _printMapAsTable(formDataMap,
              header: 'Form data | ${data.boundary}',
              printType: PrintType.request);
        } else {
          _printBlock(data.toString(), PrintType.request);
        }
      }
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final triggerTime = err.requestOptions.extra[_timeStampKey];

    if (error) {
      if (err.type == DioExceptionType.badResponse) {
        final uri = err.response?.requestOptions.uri;
        int diff = 0;
        if (triggerTime is int) {
          diff = DateTime.timestamp().millisecondsSinceEpoch - triggerTime;
        }
        _printBoxed(
            header:
                'DioError ║ Status: ${err.response?.statusCode} ${err.response?.statusMessage} ║ Time: $diff ms',
            text: uri.toString(),
            printType: PrintType.error);
        if (err.response != null && err.response?.data != null) {
          logPrint(err.type.toString(), PrintType.error);
          _printResponse(err.response!);
        }
        _printLine(pre: '', printType: PrintType.error);
        logPrint('', PrintType.error);
      } else {
        _printBoxed(
            header: 'DioError ║ ${err.type}',
            text: err.message,
            printType: PrintType.error);
      }
    }
    logPrint(_cURLRepresentation(err.requestOptions), PrintType.curl);
    handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);

    final triggerTime = response.requestOptions.extra[_timeStampKey];

    int diff = 0;
    if (triggerTime is int) {
      diff = DateTime.timestamp().millisecondsSinceEpoch - triggerTime;
    }
    _printResponseHeader(response, diff);
    if (responseHeader) {
      final responseHeaders = <String, String>{};
      response.headers
          .forEach((k, list) => responseHeaders[k] = list.toString());
      _printMapAsTable(responseHeaders,
          header: 'Headers', printType: PrintType.response);
    }

    if (responseBody) {
      if (response is Response<Stream>) {
        logPrint('Body', PrintType.response);
        logPrint('', PrintType.response);
        logPrint(response.toString(), PrintType.response);
        return;
      }
      if (usePrint) {
        if (kIsWeb) {
          logPrint('Body', PrintType.response);
          logPrint('', PrintType.response);
          logPrint(response.toString(), PrintType.response);
          logPrint('', PrintType.response);
        } else {
          Isolate.run(() {
            logPrint('Body', PrintType.response);
            logPrint('', PrintType.response);
            logPrint(response.toString(), PrintType.response);
            logPrint('', PrintType.response);
          });
        }
        return;
      }
      if (kIsWeb) {
        logPrint('Body', PrintType.response);
        logPrint('', PrintType.response);
        _printResponse(response);
        logPrint('', PrintType.response);
        _printLine(pre: '', printType: PrintType.response);
      } else {
        Isolate.run(() {
          logPrint('Body', PrintType.response);
          logPrint('', PrintType.response);
          _printResponse(response);
          logPrint('', PrintType.response);
          _printLine(pre: '', printType: PrintType.response);
        });
      }
    }
  }

  void _printBoxed(
      {String? header, String? text, required PrintType printType}) {
    logPrint('', printType);
    logPrint('$header', printType);
    logPrint('  $text', printType);
    _printLine(pre: '', printType: printType);
  }

  void _printResponse(Response response) {
    if (response.data != null) {
      if (response.data is Map) {
        _printPrettyMap(response.data as Map, printType: PrintType.response);
      } else if (response.data is Uint8List) {
        logPrint('${_indent()}[', PrintType.response);
        _printUint8List(response.data as Uint8List,
            printType: PrintType.response);
        logPrint('${_indent()}]', PrintType.response);
      } else if (response.data is List) {
        logPrint('${_indent()}[', PrintType.response);
        _printList(response.data as List, printType: PrintType.response);
        logPrint('${_indent()}]', PrintType.response);
      } else {
        _printBlock(response.data.toString(), PrintType.response);
      }
    }
  }

  String _indent([int tabCount = kInitialTab]) => tabStep * tabCount;

  void _printResponseHeader(Response response, int responseTime) {
    final uri = response.requestOptions.uri;
    final method = response.requestOptions.method;
    _printBoxed(
        header:
            'Response ║ $method ║ Status: ${response.statusCode} ${response.statusMessage}  ║ Time: $responseTime ms',
        text: uri.toString(),
        printType: PrintType.response);
  }

  void _printRequestHeader(RequestOptions options) {
    final uri = options.uri;
    final method = options.method;
    _printBoxed(
        header: 'Request  $method ',
        text: uri.toString(),
        printType: PrintType.request);
  }

  void _printLine(
          {String pre = '', String suf = '', required PrintType printType}) =>
      logPrint('$pre${'' * maxWidth}$suf', printType);

  void _printKV(String? key, Object? v, PrintType printType) {
    final pre = ' $key: ';
    final msg = v.toString();
    if (key?.toString().toLowerCase() ==
        HttpHeaders.authorizationHeader.toLowerCase()) {
      logPrint('$pre$msg', printType);
      return;
    }
    if (pre.length + msg.length > maxWidth) {
      logPrint(pre, printType);
      _printBlock(msg, printType);
    } else {
      logPrint('$pre$msg', printType);
    }
  }

  void _printBlock(String msg, PrintType printType) {
    final lines = (msg.length / maxWidth).ceil();
    for (var i = 0; i < lines; ++i) {
      logPrint(
          (i >= 0 ? ' ' : '') +
              msg.substring(i * maxWidth,
                  math.min<int>(i * maxWidth + maxWidth, msg.length)),
          printType);
    }
  }

  void _printPrettyMap(Map data,
      {int initialTab = kInitialTab,
      bool isListItem = false,
      bool isLast = false,
      required PrintType printType}) {
    var tabs = initialTab;
    final isRoot = tabs == kInitialTab;
    final initialIndent = _indent(tabs);
    tabs++;

    if (isRoot || isListItem) logPrint('$initialIndent{', printType);

    for (var index = 0; index < data.length; index++) {
      final isLast = index == data.length - 1;
      final key = '"${data.keys.elementAt(index)}"';
      dynamic value = data[data.keys.elementAt(index)];
      if (value is String) {
        value = '"${value.toString().replaceAll(RegExp(r'([\r\n])+'), " ")}"';
      }
      if (value is Map) {
        if (compact && _canFlattenMap(value)) {
          logPrint(
              '${_indent(tabs)} $key: $value${!isLast ? ',' : ''}', printType);
        } else {
          logPrint('${_indent(tabs)} $key: {', printType);
          _printPrettyMap(value, initialTab: tabs, printType: printType);
        }
      } else if (value is List) {
        if (compact && _canFlattenList(value)) {
          logPrint('${_indent(tabs)} $key: ${value.toString()}', printType);
        } else {
          logPrint('${_indent(tabs)} $key: [', printType);
          _printList(value, tabs: tabs, printType: printType);
          logPrint('${_indent(tabs)} ]${isLast ? '' : ','}', printType);
        }
      } else {
        final msg = value.toString().replaceAll('\n', '');
        final indent = _indent(tabs);
        final linWidth = maxWidth - indent.length;
        if (msg.length + indent.length > linWidth) {
          final lines = (msg.length / linWidth).ceil();
          for (var i = 0; i < lines; ++i) {
            final multilineKey = i == 0 ? '$key:' : '';
            logPrint(
                '${_indent(tabs)} $multilineKey ${msg.substring(i * linWidth, math.min<int>(i * linWidth + linWidth, msg.length))}',
                printType);
          }
        } else {
          logPrint(
              '${_indent(tabs)} $key: $msg${!isLast ? ',' : ''}', printType);
        }
      }
    }

    logPrint('$initialIndent}${isListItem && !isLast ? ',' : ''}', printType);
  }

  void _printList(List list,
      {int tabs = kInitialTab, required PrintType printType}) {
    for (var i = 0; i < list.length; i++) {
      final element = list[i];
      final isLast = i == list.length - 1;
      if (element is Map) {
        if (compact && _canFlattenMap(element)) {
          logPrint(
              '${_indent(tabs)}  $element${!isLast ? ',' : ''}', printType);
        } else {
          _printPrettyMap(element,
              initialTab: tabs + 1,
              isListItem: true,
              isLast: isLast,
              printType: printType);
        }
      } else {
        logPrint(
            '${_indent(tabs + 2)} $element${isLast ? '' : ','}', printType);
      }
    }
  }

  void _printUint8List(Uint8List list,
      {int tabs = kInitialTab, required PrintType printType}) {
    var chunks = [];
    for (var i = 0; i < list.length; i += chunkSize) {
      chunks.add(
        list.sublist(
            i, i + chunkSize > list.length ? list.length : i + chunkSize),
      );
    }
    for (var element in chunks) {
      logPrint('${_indent(tabs)} ${element.join(", ")}', printType);
    }
  }

  void _printMapAsTable(Map? map,
      {String? header, required PrintType printType}) {
    if (map == null || map.isEmpty) return;
    logPrint(' $header ', printType);
    for (final entry in map.entries) {
      _printKV(entry.key.toString(), entry.value, printType);
    }
    _printLine(pre: '', printType: printType);
  }

  bool _canFlattenMap(Map map) {
    return map.values
            .where((dynamic val) => val is Map || val is List)
            .isEmpty &&
        map.toString().length < maxWidth;
  }

  bool _canFlattenList(List list) {
    return list.length < 10 && list.toString().length < maxWidth;
  }

  String _cURLRepresentation(RequestOptions options) {
    List<String> components = ['curl -i'];
    if (options.method.toUpperCase() != 'GET') {
      components.add('-X ${options.method}');
    }

    options.headers.forEach((k, v) {
      if (k != 'Cookie') {
        components.add('-H "$k: $v"');
      }
    });

    if (options.data != null) {
      // FormData can't be JSON-serialized, so keep only their fields attributes
      if (options.data is FormData == true) {
        options.data = Map.fromEntries(options.data.fields);
      }

      final data = json.encode(options.data).replaceAll('"', '\\"');
      components.add('-d "$data"');
    }

    components.add('"${options.uri.toString()}"');

    return components.join(' ');
  }
}

class FilterArgs {
  final bool isResponse;

  final dynamic data;

  bool get hasStringData => data is String;

  bool get hasMapData => data is Map;

  bool get hasListData => data is List;

  bool get hasUint8ListData => data is Uint8List;

  bool get hasJsonData => hasMapData || hasListData;

  const FilterArgs(this.isResponse, this.data);
}

enum PrintType { request, response, error, curl }
