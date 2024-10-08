import 'package:adast/%20themes/colors_shemes.dart';
import 'package:flutter/material.dart';
import '../ themes/themes.dart';

class CustomButton extends StatelessWidget {
  final Function() onTap;
  final String text;
  final bool icon;
  final bool loading;
  const CustomButton({super.key, required this.onTap,required this.text,  this.icon=false,this.loading=false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: InkWell(
         
        borderRadius: BorderRadius.circular(10),
        // radius: 20,
        splashColor:!icon? const Color.fromARGB(255, 2, 2, 2):greentransparent,
        onTap: onTap,
        child: Container(
          width: MediaQuery.of(context).size.width - 50,
          height: 50,
          decoration:!icon?greenbuttonDecoration:whiteButtonDecoration,
          child:  Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                
                loading?const SizedBox(width: 20,height: 20, child:  CircularProgressIndicator(color: white,)):Text(
                  text,
                  style:!icon? whiteTextStyle:greyTextStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }



}
