
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../ themes/colors_shemes.dart';
import '../../../ themes/themes.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          title: Text('Terms and Conditions', style: blackTextStyle),
        ),
        body: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: TermsAndConditionsContent(),
          ),
        ),
      ),
    );
  }
}

class TermsAndConditionsContent extends StatelessWidget {
  const TermsAndConditionsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          'Introduction',
          style:mediumBlackTextStyle,
        ),
        const SizedBox(height: 8),
        Text(
          'Welcome to Adast! By using our app, you agree to these terms and conditions. Please read them carefully.',style: blackPlainTextStyle,
        ),
        const SizedBox(height: 16),
        Text(
          'Services',
          style:mediumBlackTextStyle,
        ),
        const SizedBox(height: 8),
        Text(
          'Adast allows users to discover nearby fashion shops using a map feature, view items available in the shops, and reserve items for a few days by paying a small advance amount using Razorpay.',style: blackPlainTextStyle,
        ),
        const SizedBox(height: 16),
        Text(
          'User Accounts',
          style:mediumBlackTextStyle,
        ),
        const SizedBox(height: 8),
        Text(
          'To use our services, you must create an account. We collect and store your email, image, and name for account management purposes. By creating an account, you agree to provide accurate information.',
        style: blackPlainTextStyle,),
        const SizedBox(height: 16),
        Text(
          'Data Collection and Use',
          style:mediumBlackTextStyle,
        ),
        const SizedBox(height: 8),
        Text(
          'We use Firebase to store and manage user data. We collect your email, image, and name to create and manage your account. Your data is used to personalize your experience and improve our services.',
       style: blackPlainTextStyle, ),
        const SizedBox(height: 16),
        Text(
          'Reservations and Payments',
          style:mediumBlackTextStyle,
        ),
        const SizedBox(height: 8),
        Text(
          'You can reserve items from shops by paying a small advance amount through Razorpay. Please note that reservations cannot be canceled, but you can replace the item with another from the same store.',
        style: blackPlainTextStyle,),
        const SizedBox(height: 16),
        Text(
          'Use of Location Data',
          style:mediumBlackTextStyle,
        ),
        const SizedBox(height: 8),
        Text(
          'To help you find nearby fashion shops, we collect and use your location data. You can control location sharing through your device settings.',
        style: blackPlainTextStyle,),
        const SizedBox(height: 16),
        Text(
          'User Responsibilities',
          style:mediumBlackTextStyle,
        ),
        const SizedBox(height: 8),
        Text(
          'You are responsible for maintaining the confidentiality of your account information and for all activities that occur under your account. Please notify us immediately of any unauthorized use of your account.',
        style: blackPlainTextStyle,),
        const SizedBox(height: 16),
        Text(
          'Changes to These Terms',
          style:mediumBlackTextStyle,
        ),
        const SizedBox(height: 8),
        Text(
          'We may update these terms and conditions from time to time. We will notify you of any significant changes by posting the new terms on this page.',
       style: blackPlainTextStyle, ),
        const SizedBox(height: 16),
        Text(
          'Contact Us',
          style:mediumBlackTextStyle,
        ),
        const SizedBox(height: 8),
        Text(
          'If you have any questions about these terms and conditions, please contact us at',
       style: blackPlainTextStyle, ),
        GestureDetector(
          onTap: () async {
            final Uri params = Uri(
              scheme: 'mailto',
              path: 'vishnumeloth13@gmail.com',
              query:
                  'subject=Terms%20and%20Conditions%20Inquiry', 
            );
            if (await canLaunchUrl(params)) {
              await launchUrl(params);
            } else {
              log('Could not launch $params');
            }
          },
          child: Text(
            'vishnumeloth13@gmail.com',
            style: urlTextStyle,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'By using Adast, you agree to these terms and conditions. Thank you for using our app!',
       style: blackPlainTextStyle, ),
      ],
    );
  }
}
