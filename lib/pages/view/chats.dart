import 'package:flutter/material.dart';

import '../../widgets/image_text.dart';
import '../../widgets/search.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),

        // Title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Chats!',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32,
              color: Colors.black,
            ),
          ),
        ),

        // Search Bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: SearchWidget(),
        ),

        const SizedBox(height: 16),

        // ListView inside Expanded → NO OVERFLOW
        const Expanded(
          child: ImageText(),
        ),
      ],
    );
  }
}
