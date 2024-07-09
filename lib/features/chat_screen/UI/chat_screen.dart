import 'package:adast/custom_widgets/custom_cached_network_image.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomCachedNetworkImage(image: ''),
        title: const Text('name'),
      ),
    );
  }
}