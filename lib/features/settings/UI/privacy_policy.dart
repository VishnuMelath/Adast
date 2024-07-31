import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../ themes/colors_shemes.dart';
import '../../../ themes/themes.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          title: Text('Privacy Policy', style: blackTextStyle),
        ),
        body: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: PrivacyPolicyContent(),
          ),
        ),
      ),
    );
  }
}

class PrivacyPolicyContent extends StatelessWidget {
  const PrivacyPolicyContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Privacy Policy for Adast',
          style: mediumBlackTextStyle,
        ),
        const SizedBox(height: 8),
        Text(
          'Introduction',
          style: mediumBlackTextStyle,
        ),
        const SizedBox(height: 8),
        Text(
          'Adast is a mobile application that allows users to discover nearby fashion shops, view their items, and reserve items for a fee. This privacy policy outlines how we collect, use, and protect your personal information.',
          style: blackPlainTextStyle,
        ),
        const SizedBox(height: 16),
        Text(
          'Information We Collect',
          style: mediumBlackTextStyle,
        ),
        const SizedBox(height: 8),
        Text(
          'Personal Information: We collect basic personal information such as your name, email address, and profile picture when you create an account.',
          style: blackPlainTextStyle,
        ),
        // const Text(
        //   'Location Data: To help you find nearby fashion shops, we collect your location data. You can control location sharing through your device settings.',
        // ),
        Text(
          'Payment Information: If you choose to reserve an item, we collect payment information through Razorpay, our payment gateway. We do not store your full payment details.',
          style: blackPlainTextStyle,
        ),
        const SizedBox(height: 16),
        Text(
          'How We Use Your Information',
          style: mediumBlackTextStyle,
        ),
        const SizedBox(height: 8),
        Text(
          'Account Management: We use your information to create and manage your Adast account.',
          style: blackPlainTextStyle,
        ),
        const Text(
          'Nearby Shop Suggestions: Your location data is used to suggest nearby fashion shops.',
        ),
        Text(
          'Payment Processing: Payment information is used to process item reservations through Razorpay.',
          style: blackPlainTextStyle,
        ),

        const SizedBox(height: 16),
        Text(
          'Data Sharing',
          style: mediumBlackTextStyle,
        ),
        const SizedBox(height: 8),
        Text(
          'We share your information with the following third-party service providers:',
          style: blackPlainTextStyle,
        ),
        Text(
          'Firebase: We use Firebase to store and manage user data.',
          style: blackPlainTextStyle,
        ),
        Text(
          'Razorpay: We use Razorpay to process payments.',
          style: blackPlainTextStyle,
        ),
        Text(
          'We do not sell or rent your personal information to third parties for marketing purposes.',
          style: blackPlainTextStyle,
        ),
        const SizedBox(height: 16),
        Text(
          'Data Security',
          style: mediumBlackTextStyle,
        ),
        const SizedBox(height: 8),
        Text(
          'We implement reasonable security measures to protect your personal information from unauthorized access, disclosure, alteration, or destruction. However, no method of transmission or storage is completely secure.',
          style: blackPlainTextStyle,
        ),
        const SizedBox(height: 16),
        Text(
          'Your Rights',
          style: mediumBlackTextStyle,
        ),
        const SizedBox(height: 8),
        Text(
          'You have the right to access, correct, or delete your personal information. You can also request to restrict the processing of your data or object to certain processing activities.',
          style: blackPlainTextStyle,
        ),
        const SizedBox(height: 16),
        Text(
          "Children's Privacy",
          style: mediumBlackTextStyle,
        ),
        const SizedBox(height: 8),
        Text(
          'Adast is not intended for use by children under the age of 13. We do not knowingly collect personal information from children.',
          style: blackPlainTextStyle,
        ),
        const SizedBox(height: 16),
        Text(
          'Changes to This Privacy Policy',
          style: mediumBlackTextStyle,
        ),
        const SizedBox(height: 8),
        Text(
          'We may update this privacy policy from time to time. We will notify you of any significant changes by posting the new policy on this page.',
          style: blackPlainTextStyle,
        ),
        const SizedBox(height: 16),
        Text(
          'Contact Us',
          style: mediumBlackTextStyle,
        ),
        const SizedBox(height: 8),
        Text(
          'If you have any questions about this privacy policy, please contact us at',
          style: blackPlainTextStyle,
        ),
        GestureDetector(
          onTap: () async {
            final Uri params = Uri(
              scheme: 'mailto',
              path: 'vishnumeloth13@gmail.com',
              query:
                  'subject=Privacy%20Policy%20Inquiry', 
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
          'Remember to replace the placeholders with your specific information and consult with a legal professional to ensure compliance with applicable laws.',
          style: blackPlainTextStyle,
        ),
      ],
    );
  }
}
