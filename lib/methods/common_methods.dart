

import 'package:adast/%20themes/constants.dart';

String capitalize(String string)
{
  return string[0].toUpperCase()+string.substring(1);
}

String dateString(DateTime date)
{
  return '${date.day} ${month[date.month]!} , ${date.year}' ;
}