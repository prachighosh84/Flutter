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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: Row(
          children: [
            // USER ICON + TEXT
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.blueAccent,
                  child: Image.asset(
                    'assets/user2.png',
                    width: 150,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  "Hi Prachi",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            const SizedBox(width: 12),

            // SEARCH BAR (Flexible)
            Expanded(
              child: Container(
                height: 38,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.grey),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),      body: ListView.builder(
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
    );
  }
}
