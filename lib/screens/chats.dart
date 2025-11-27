import 'package:flutter/material.dart';
import 'package:m2i_cours_flutter/widgets/chat_item.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {

    final List<Map<String, dynamic>> chats = [
      {
        'user': 'Alice',
        'message': 'Hey! Are you coming today?',
        'time': '10:45 AM',
        'status': UserStatus.online
      },
      {
        'user': 'Bob',
        'message': 'Sure, see you there.',
        'time': '09:30 AM',
        'status': UserStatus.away
      },
      {
        'user': 'Charlie',
        'message': 'Can you send me the report?',
        'time': 'Yesterday',
        'status': UserStatus.offline
      },
      {
        'user': 'Diana',
        'message': 'Happy Birthday! 🎉',
        'time': 'Yesterday',
        'status': UserStatus.online
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0f172b),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Chats",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true, // prevent height issues
                physics: NeverScrollableScrollPhysics(), // disable inner scroll
                itemCount: chats.length,
                itemBuilder: (context, index) {
                  final chat = chats[index];
                  return ChatItem(
                    userName: chat['user'],
                    message: chat['message'],
                    time: chat['time'],
                    status: chat['status'],
                  );
                },
              ),
            ],
          ),
        )
    );
  }
}
