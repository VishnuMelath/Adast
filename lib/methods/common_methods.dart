

import 'package:adast/constants/constants.dart';

String capitalize(String string)
{
  return string[0].toUpperCase()+string.substring(1);
}

String dateString(DateTime date)
{
  return '${date.day} ${month[date.month]!} , ${date.year}' ;
}

String dateTimeString(DateTime date)
{
  String ampm=date.hour<12?'am':'pm';
  return '${month[date.month]!} ${date.day} ,${date.year} (${date.hour}:${date.minute} $ampm)' ;
}