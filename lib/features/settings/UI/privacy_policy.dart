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
    return  Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
          ),
        ],
      ),
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Text(
              'Privacy Policy for adast',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              'Last Updated: 06/08/2024',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Welcome to adast! Your privacy is important to us. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our application. By using adast, you agree to the terms of this Privacy Policy.',
          ),
          SizedBox(height: 20),
          Text(
            '1. Information We Collect',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'We collect the following information from you to provide a personalized experience:',
          ),
          SizedBox(height: 10),
          _buildBulletPoint(
            'Profile Photo: Used to personalize your profile within the app.',
          ),
          _buildBulletPoint(
            'Name: Used to address you within the app.',
          ),
          _buildBulletPoint(
            'Email Address: Used for account verification, notifications, and support.',
          ),
          SizedBox(height: 20),
          Text(
            '2. How We Use Your Information',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'We use the collected information for the following purposes:',
          ),
          SizedBox(height: 10),
          _buildBulletPoint(
            'Personalization: To personalize your experience and provide tailored content.',
          ),
          _buildBulletPoint(
            'Account Management: To manage your account and provide customer support.',
          ),
          _buildBulletPoint(
            'Location Services: To provide users with the location of nearby fashion shops.',
          ),
          _buildBulletPoint(
            'In-App Chat: To facilitate communication between users and sellers.',
          ),
          _buildBulletPoint(
            'Transactions: To process transactions securely within the app.',
          ),
          SizedBox(height: 20),
          Text(
            '3. Information Sharing and Disclosure',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'We do not share, sell, or distribute your personal information to any third parties. All information collected is used solely within adast for the purposes mentioned above.',
          ),
          SizedBox(height: 20),
          Text(
            '4. Data Security',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'We take the security of your personal information seriously and use industry-standard security measures to protect your data from unauthorized access, disclosure, alteration, and destruction.',
          ),
          SizedBox(height: 10),
          Text(
            'Security Measures:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          _buildBulletPoint(
            'Encryption: We use encryption to protect your data during transmission and storage.',
          ),
          _buildBulletPoint(
            'Secure Storage: We store your data on secure servers provided by Firebase services, which comply with industry security standards.',
          ),
          _buildBulletPoint(
            'Payment Processing: We use Razorpay for processing transactions securely. Razorpay adheres to the highest security standards to protect your financial information.',
          ),
          SizedBox(height: 20),
          Text(
            '5. Your Rights',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Text('You have the right to:'),
          SizedBox(height: 10),
          _buildBulletPoint(
            'Access Your Information: Request a copy of the personal information we hold about you.',
          ),
          _buildBulletPoint(
            'Update Your Information: Correct or update your personal information.',
          ),
          _buildBulletPoint(
            'Delete Your Information: Request the deletion of your personal information.',
          ),
          SizedBox(height: 20),
          Text(
            '6. Changes to This Privacy Policy',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'We may update this Privacy Policy from time to time. If we make significant changes, we will notify you through the app or by other means before the changes take effect. We encourage you to review this Privacy Policy periodically to stay informed about how we are protecting your information.',
          ),
          SizedBox(height: 20),
          Text(
            '7. Contact Us',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'If you have any questions or concerns about this Privacy Policy or our data practices, please contact us at:',
          ),
          SizedBox(height: 10),
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
          Text(
            'Phone: 9605391056',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Effective Date: 06/08/2024',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'By using adast, you acknowledge that you have read and understood this Privacy Policy and agree to its terms.',
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('• ', style: TextStyle(fontSize: 16.0)),
          Expanded(
            child: Text(text, style: TextStyle(fontSize: 16.0)),
          ),
        ],
      ),
    );
  }
}