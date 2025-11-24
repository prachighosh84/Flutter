import 'package:flutter/material.dart';
import 'package:m2i_cours_flutter/screens/channels.dart';
import 'package:m2i_cours_flutter/screens/chats.dart';
import 'package:m2i_cours_flutter/screens/profile.dart';
import 'package:m2i_cours_flutter/screens/sign_in.dart';
import 'package:m2i_cours_flutter/widgets/icon_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    final List<Color> colors = [
      Colors.blue,
      Colors.green,
      Colors.black38,
      Colors.red,
      Colors.purple,
      Colors.teal,
    ];


    final List<Map<String, dynamic>> cardData = [
      {
        'title': 'Chats',
        'subtitle': 'Open chat screen',
        'icon': Icons.chat,
        'page': const ChatsPage(),
      },

      {
        'title': 'Profile',
        'subtitle': 'View your profile',
        'icon': Icons.person,
        'page': const ProfilePage(),
      },
      {
        'title': 'Channels',
        'subtitle': 'View your Channels',
        'icon': Icons.tag,
        'page': const ChannelsPage(),
      },
      {
        'title': 'Notifications',
        'subtitle': 'View  notifications',
        'icon': Icons.notifications,
        'page': const ChannelsPage(),
      },

    ];


    return Scaffold(
      backgroundColor: Color(0xFF0f172b),
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
                  child:    Image.asset(
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
            ElevatedButton(
              child: const Text('Sign In'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) =>  SignInPage(),
                  ),
                );
              },
            ),

          ],
        ),
      ),

      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: cardData.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          childAspectRatio: 3 / 2,
        ),
        itemBuilder: (context, index) {
          final data = cardData[index];
          return IconCard(
            icon: data['icon'],
            title: data['title'],
            subtitle: data['subtitle'],
            color: colors[index % colors.length],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => data['page']),
              );
            },
          );
        },
      ),
    );
  }
}
