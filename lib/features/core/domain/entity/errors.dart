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
  String? code;
  int? status;

  ServerError({this.code, this.status});

  @override
  String getError(BuildContext context) {
    return errorMessagesAr[code] ?? CoreTranslations.of(context)!.errorMessage;
  }
}

class InternalError extends Failure {
  String? message;

  InternalError({this.message});

  @override
  String getError(BuildContext context) {
    return message ?? CoreTranslations.of(context)!.errorMessage;
  }
}

const Map<String, String> errorMessagesAr = {
  "INVALID_THUMBNAIL": "الصورة المصغرة غير صالحة",
  "IMAGES_6_AT_MOST": "يمكن رفع 6 صور كحد أقصى",
  "WRONG_STATE_SEQUENCE": "تسلسل حالة العقار غير صحيح",
  "PROPERTY_NOT_COMPLETED": "العقار لم يكتمل بعد",
  "BAD_INPUT": "بيانات الإدخال غير صحيحة",
  "NOT_FOUND": "العنصر غير موجود",
  "FORBIDDEN": "لا تملك صلاحية الوصول لهذا المورد",
  "CONFLICT": "حدث تعارض في البيانات",
  "INTERNAL": "خطأ داخلي في النظام",
  "UNPROCESSABLE_ENTITY": "تعذر معالجة الطلب",
  "UNAUTHENTICATED": "لم يتم تسجيل الدخول",
  "UNAUTHORIZED": "غير مخول للقيام بهذه العملية",
  "INVALID_JWT_TOKEN": "رمز التوثيق غير صالح",
  "JWT_TOKEN_EXPIRED": "انتهت صلاحية رمز التوثيق",
  "FORBIDDEN_QUERY_FIELD": "حقل الاستعلام غير مسموح به",
  "FORBIDDEN_BODY_FIELD": "حقل البيانات غير مسموح به",
  "WRONG_OTP": "رمز التحقق خاطئ",
  "WRONG_PASSWORD": "كلمة المرور غير صحيحة",
  "EMAIL_NOT_FOUND": "البريد الإلكتروني غير موجود",
  "USER_NOT_FOUND": "المستخدم غير موجود",
  "UNKNOWN_ERROR": "حدث خطأ غير معروف",
  "PASSWORD_MISSMATCH": "كلمة المرور لا تتطابق",
  "FILE_SIZE_NOT_ALLOWED": "حجم الملف غير مسموح به",
  "FILE_TYPE_NOT_ALLOWED": "نوع الملف غير مسموح به",
  "ACCOUNT_NOT_COMPLETED_YET": "الحساب لم يكتمل بعد",
  "INVALID_CREDENTIALS": "بيانات تسجيل الدخول غير صحيحة",
  "USER_ALREADY_EXISTS": "المستخدم موجود بالفعل",
  "VERSION_NOT_SUPPORTED" : "يرجى تحديث التطبيق"
};
