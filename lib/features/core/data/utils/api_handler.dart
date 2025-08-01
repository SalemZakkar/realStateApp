import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:real_state/features/core/domain/entity/failures.dart';

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
        return left(NetworkFailure(connectionTimeOut: true));
      } else if (e.type == DioExceptionType.badResponse) {
        Map<String, dynamic> errorBody = {};
        try {
          if (e.response?.data != null) {
            if (e.response?.data is String) {
              errorBody = jsonDecode(e.response!.data!);
            } else {
              errorBody = e.response?.data ?? {};
            }
          }
        } catch (e) {
          debugPrint(e.toString());
        }
        return left(
          ServerFailure(
            errorCode: _getErrorCode(code: e.response?.statusCode ?? -1),
            message: errorBody['message'] ?? 'حدث خطأ',
          ),
        );
      } else {
        return left(NetworkFailure(connectionTimeOut: false));
      }
    } catch (e, stack) {
      _logger.e(e.toString(), error: e, stackTrace: stack);
      return left(
        ServerFailure(
          errorCode: ServerErrorCode.serverError,
          message: "حدث خطأ",
        ),
      );
    }
  }

  ServerErrorCode _getErrorCode({required int code}) {
    switch (code) {
      case 403:
        return ServerErrorCode.accessDenied;
      case 401:
        return ServerErrorCode.unauthenticated;
      case 404:
        return ServerErrorCode.notFound;
      case 400:
        return ServerErrorCode.wrongInput;
      default:
        return ServerErrorCode.serverError;
    }
  }
}
