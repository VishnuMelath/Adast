import 'package:adast/%20themes/colors_shemes.dart';
import 'package:adast/features/profile/UI/widgets/customtile.dart';
import 'package:adast/features/settings/UI/widgets/edit_profile.dart';
import 'package:adast/features/settings/UI/widgets/logout_button.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: ListView(
            children: [
              customListTile('Edit profile', () {
                editProfile(context);
              },),
              customListTile('Privacy policy', () {
                
              },),
              customListTile('Help', () {
                
              },),
              customListTile('About', () {
                
              },),
              logoutButton(context)
            ],
          ),
        ),
      ),
    );
  }
}