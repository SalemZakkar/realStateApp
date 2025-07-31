import 'package:real_state/features/core/domain/enum/otp_status_type.dart';

class OtpStatus {
  DateTime nextDate;
  OtpStatusType status;

  OtpStatus({required this.status, required this.nextDate});
}
