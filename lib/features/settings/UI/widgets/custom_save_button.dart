import 'package:flutter/material.dart';

import '../../../../ themes/colors_shemes.dart';
import '../../../../ themes/themes.dart';

Widget customSaveCancelButton({bool save=true,required Function() onTap, ValueNotifier<bool>? loading})
{
  var text=save?'save':'cancel';
  loading ??= ValueNotifier(false);
   return Expanded(
     child: ValueListenableBuilder(
      valueListenable: loading,
       builder: (context,value,_) {
         return Padding(
            padding: const EdgeInsets.all(18.0),
            child: InkWell(
               
              borderRadius: BorderRadius.circular(10),
              // radius: 20,
              splashColor:save? const Color.fromARGB(255, 2, 2, 2):greentransparent,
              onTap: onTap,
              child: Container(
              
                height: 50,
                decoration:save?greenbuttonDecoration:whiteButtonDecoration,
                child:  Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      
                      loading!.value?const SizedBox(width: 20,height: 20, child:  CircularProgressIndicator(color: white,)):Text(
                        text,
                        style:save? whiteTextStyle:greyTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
       }
     ),
   );
}