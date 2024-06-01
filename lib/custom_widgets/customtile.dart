
import 'package:flutter/material.dart';

import '../ themes/constants.dart';


Widget customListTile(String title)
{
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ListTile(
      onTap: () async{

        //todo navigate to the particular page
      },
      leading: Icon(icons[title]),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios_outlined,size: 17,),
    ),
  );

}