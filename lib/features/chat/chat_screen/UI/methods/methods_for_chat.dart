

import 'package:flutter/material.dart';

import '../../../../../ themes/themes.dart';
import '../../../../../methods/common_methods.dart';
import '../../../../../models/message_model.dart';
import '../widgets/message_tile.dart';



Map<DateTime, List<MessageModel>> group(List<MessageModel> messages) {
  Map<DateTime, List<MessageModel>> listedMessages = {};
  for (var message in messages) {
    var date = message.timestamp.toDate();
    var temp = DateTime(date.year, date.month, date.day);
    listedMessages[temp] = listedMessages[temp] ?? [];
    listedMessages[temp]!.add(message);
  }
  return listedMessages;
}

List<Widget> convertToWidget(Map<DateTime, List<MessageModel>> map) {
  List<Widget> widgets = [];
  for (var element in map.keys) {
    String date=dateString(element);
    if(DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day)==element)
    {
      date='today';
    }
    if(DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day-1)==element)
    {
      date='yesterday';
    }
    for (var element1 in map[element]!) {
      widgets.add(MessageTile(
        messageModel: element1,
      ))
      ;
    }
    widgets.add(Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          const Expanded(child: Divider()),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(date,style: greyTextStyle,),
          ),
          const Expanded(child: Divider()),
        ],
      ),
    ));
  }
  return widgets;
}
