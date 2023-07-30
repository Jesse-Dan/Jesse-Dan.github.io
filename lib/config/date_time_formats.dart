import 'package:intl/intl.dart';

/// 17 Jan, 2023 12:30pm
var dateWithTime = DateFormat.yMMMMd().add_jm();

// var dateWithoutTimeButPosition = DateFormat('MMM d\'th\', yyyy');

/// Suffix
String getDaySuffix(int day) {
  if (day >= 11 && day <= 13) {
    return 'th';
  }
  switch (day % 10) {
    case 1:
      return 'st';
    case 2:
      return 'nd';
    case 3:
      return 'rd';
    default:
      return 'th';
  }
}

/// Jan 17th, 2023

dateWithoutTimeButPosition({required DateTime date}) {
  String formattedDate = DateFormat('MMM d').format(date);
  String daySuffix = getDaySuffix(date.day);
  String finalDate = '$formattedDate$daySuffix, ${date.year}';
  return finalDate;
}

/// 2023/02/02
var dateWithSlashesSeperating = DateFormat('yyyy/MMM/dd');

/// 2023-02-02
var dateWithDashesSeperating = DateFormat('yyyy-MMM-dd');

/// 17 Jan, 2023
var dateWithoutTIme = DateFormat.yMMMMd();

const MAX_PAGE = 0;

const PAGE_SIZE = 10;

const ALLOW_AUTH = true;
