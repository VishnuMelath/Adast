
import 'package:adast/%20themes/themes.dart';
import 'package:adast/models/user_model.dart';
import 'package:flutter/material.dart';

class Profiletile extends StatelessWidget {
  final UserModel user;
  const Profiletile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:  18.0,left: 18,right: 18),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                user.image ??
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8A2wOvDj7sAobit1mD4lCc6ilEaBm_CF3AQ&s',
                width: 50,
                height: 50,
              ),
            ),
            title: Text(
              user.name,
              style: blackTextStyle,
            ),
            subtitle: Text(user.email,style: greyTextStyle,),
          ),
        ),
      ),
    );
  }
}
