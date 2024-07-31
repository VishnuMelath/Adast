import 'dart:developer';

import 'package:adast/%20themes/colors_shemes.dart';
import 'package:adast/features/profile/UI/widgets/customtile.dart';
import 'package:adast/features/settings/UI/about.dart';
import 'package:adast/features/settings/UI/privacy_policy.dart';
import 'package:adast/features/settings/UI/widgets/edit_profile.dart';
import 'package:adast/features/settings/UI/widgets/logout_button.dart';
import 'package:adast/features/settings/UI/terms_and_conditions.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: backgroundColor,
          ),
          backgroundColor: backgroundColor,
          body: ListView(
            children: [
              customListTile('Edit profile', () {
                editProfile(context);
              },),
              customListTile('Privacy policy', () {
                Navigator.push(context,MaterialPageRoute(builder: (context) =>const PrivacyPolicyPage(),));
              },),
              customListTile('Terms and Conditions', () {
                Navigator.push(context,MaterialPageRoute(builder: (context) =>const TermsAndConditionsPage(),));
              },),
              customListTile('Help', () async{
                 final Uri params = Uri(
              scheme: 'mailto',
              path: 'vishnumeloth13@gmail.com',
              query:
                  'subject=Adast%20Inquiry', 
            );
            if (await canLaunchUrl(params)) {
              await launchUrl(params);
            } else {
              log('Could not launch $params');
            }
              },),
              customListTile('About', () {
                Navigator.push(context,MaterialPageRoute(builder: (context) =>const About(),));
              },),

              logoutButton(context)
            ],
          ),
        ),
      ),
    );
  }
}