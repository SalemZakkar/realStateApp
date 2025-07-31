
import 'package:flutter/cupertino.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';

abstract class Failure {

  String getError(BuildContext context){
    if (this is ServerFailure) {
      return (this as ServerFailure).message;
    }
    if (this is CustomFailure) {
      return (this as CustomFailure).message;
    }
    if (this is NetworkFailure) {
      return context.translation.noInternetConnection;
    }
    return context.translation.errorMessage;
  }
}

class ServerFailure extends Failure {
  final ServerErrorCode errorCode;
  final String message;

  ServerFailure({required this.errorCode, this.message = ''});
}

class CustomFailure extends Failure {
  final String message;

  CustomFailure({required this.message});
}

class NetworkFailure extends Failure {
  final bool connectionTimeOut;

  NetworkFailure({this.connectionTimeOut = false});
}

class UserISNotVerifiedFailure extends Failure {
  UserISNotVerifiedFailure();
}


enum ServerErrorCode {
  serverError,
  unauthenticated,
  forbidden,
  notFound,
  wrongInput,
  accessTokenExpired,
  accessDenied,
  illegalAccount,
  userOrEmailError,
  notificationInvalidToken,
}
