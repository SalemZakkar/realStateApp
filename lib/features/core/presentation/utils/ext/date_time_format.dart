import 'package:intl/intl.dart';

///Types of Date time patterns that includes
///[DateTimePattern.dateAndTime], [DateTimePattern.timeOnly] and [DateTimePattern.dateAndTime]
enum DateTimePattern {
  /// Ex: 22 Mar 2015 12:05 PM
  dMmmYyyyHhMmA,

  /// Ex: 22 Mar 23 12:05 PM
  dMmmYDotHhMmA,

  /// Ex: 22 Mar 23 12:05:01 PM
  dMmmYDotHhMmSsA,

  /// Ex: 22,Monday,2015
  ddMmmmYyyy,

  /// Ex: 22,March,2015
  dMmmYyyyWithComma,

  /// Ex: 22 Mar 2015
  dMmYyyy,

  /// Ex: 22 Mar 23
  dMmY,

  /// Ex: 22 Mar
  dMmm,

  /// Ex: 12:05 PM
  hhMmA,

  /// Ex: Mon
  shortDayName,

  /// Ex: Mon 2023
  monthWithYear,

  /// Ex: 2023-10-01
  yearMonthDay,

  /// Ex: 2023-10-12T01:15:20Z
  yearMonthDayTHMS,

  /// Ex: 2023
  year,

  //Ex: Sun,
  dayNameTriplet,

  //Ex: sunday
  dayName
}

extension CustomDateFormat on DateTime {
  /// Using when you need to customize the pattern of the date time
  String formatDateTo({required DateTimePattern dateTimePattern}) {
    String pattern = () {
      switch (dateTimePattern) {
        case DateTimePattern.dMmmYyyyHhMmA:
          return 'd MMM yyyy , h:mm a';
        case DateTimePattern.dMmmYDotHhMmA:
          return 'd MMM yy . h:mm a';
        case DateTimePattern.dMmmYDotHhMmSsA:
          return 'd MMM yy . h:mm:ss a';
        case DateTimePattern.ddMmmmYyyy:
          return 'dd,MMMM,yyyy';
        case DateTimePattern.dMmmYyyyWithComma:
          return 'd MMM,yyyy';
        case DateTimePattern.hhMmA:
          return 'hh:mm a';
        case DateTimePattern.dMmYyyy:
          return 'd MMM yyyy';
        case DateTimePattern.dMmY:
          return 'd MMM yy';
        case DateTimePattern.dMmm:
          return 'd MMM';
        case DateTimePattern.shortDayName:
          return 'EEE';
        case DateTimePattern.monthWithYear:
          return 'MMM yyyy';
        case DateTimePattern.yearMonthDay:
          return 'yyyy-MM-dd';
        case DateTimePattern.yearMonthDayTHMS:
          return 'yyyy-MM-ddTHH:mm:ssZ';
        case DateTimePattern.year:
          return 'yyyy';
        case DateTimePattern.dayNameTriplet:
          return 'EEE';
        case DateTimePattern.dayName:
          return 'EEEE';
      }
    }();
    return DateFormat(pattern).format(this);
  }
}
