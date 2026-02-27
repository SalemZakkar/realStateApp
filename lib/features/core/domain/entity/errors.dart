import 'package:core_package/core_package.dart';
import 'package:core_package/generated/core_translation/core_translations.dart';
import 'package:flutter/material.dart';

class NetworkError extends Failure {
  @override
  String getError(BuildContext context) {
    return CoreTranslations.of(context)!.noInternetConnection;
  }
}

class TimeOutError extends Failure {
  @override
  String getError(BuildContext context) {
    return CoreTranslations.of(context)!.connectionTimeOut;
  }
}

class ServerError extends Failure {
  String? message;

  ServerError(this.message);

  @override
  String getError(BuildContext context) {
    return message ?? CoreTranslations.of(context)!.errorMessage;
  }
}

class InternalError extends Failure {
  @override
  String getError(BuildContext context) {
    return CoreTranslations.of(context)!.errorMessage;
  }
}
