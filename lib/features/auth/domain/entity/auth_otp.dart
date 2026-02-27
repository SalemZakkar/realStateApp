class AuthOtp {
  String vid;
  DateTime nextDate;
  bool sent;

  AuthOtp({required this.nextDate, required this.sent, required this.vid});
}
