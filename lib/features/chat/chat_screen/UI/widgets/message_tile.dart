import 'package:adast/%20themes/colors_shemes.dart';
import 'package:adast/%20themes/themes.dart';
import 'package:adast/features/splash_screen/bloc/splashscreen_bloc.dart';
import 'package:adast/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MessageTile extends StatelessWidget {
  final MessageModel messageModel;
  const MessageTile({super.key, required this.messageModel});

  @override
  Widget build(BuildContext context) {
    bool reciever=messageModel.senderId!=context.read<SplashscreenBloc>().userModel!.email;
    return Align(
      alignment: reciever ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin:const EdgeInsets.symmetric(horizontal: 10,vertical: 5) ,
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        decoration: BoxDecoration(
            borderRadius: reciever
                ? const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(10))
                : const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(20)),
            color: reciever ? greentransparent : white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth:  MediaQuery.sizeOf(context).width*0.8
              ),
              child: Text(
                messageModel.message,
                style: blackPlainTextStyle,
              ),
            ),
            Text(DateFormat("h:mma").format(messageModel.timestamp.toDate()),style:greySmallTextStyle,)
          ],
        ),
      ),
    );
  }
}
