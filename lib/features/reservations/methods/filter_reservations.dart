import 'dart:developer';

import 'package:adast/constants/constants.dart';
import 'package:adast/models/reservation_model.dart';

List<ReservationModel> filterReservations(String status,List<ReservationModel> reservation)
{
  List<ReservationModel> filteredList=[];
  log(status);
  for (var element in reservation) {
    if(status=='Completed'&&element.status==ReservationStatus.purchased.name)
    {
      filteredList.add(element);
    }
    else if(status=='Pending'&&element.reservationTime.add(Duration(days: element.days)).isAfter(DateTime.now())&&element.status==ReservationStatus.reserved.name)
    {
      log('Pending${filteredList.length}');
      filteredList.add(element);
    }
    else if(status=='Failed'&&element.reservationTime.add(Duration(days: element.days)).isBefore(DateTime.now())&&element.status==ReservationStatus.reserved.name)
    {log('Failed${filteredList.length}');
      filteredList.add(element);
    }
  }
  log(filteredList.length.toString());
  return filteredList;
}