import 'package:flutter/material.dart';
import 'package:m2i_cours_flutter/widgets/card.dart';
import 'package:m2i_cours_flutter/pages/view/chats.dart';
import 'package:m2i_cours_flutter/pages/view/channels.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Map<String, dynamic>> cardData = [
    {'icon': Icons.chat, 'title': "Direct Messages", 'text': "Chat with friends", "route": ChatsPage()},
    {'icon': Icons.work, 'title': "Channels", 'text': "Collaborate with your workspace", "route": Channels()},
    {'icon': Icons.notifications, 'title': "Notifications", 'text': "Stay updated", "route": Channels()},
    {'icon': Icons.settings, 'title': "Settings", 'text': "Customize your app", "route": Channels()},
    {'icon': Icons.group, 'title': "Groups", 'text': "Manage your groups", "route": Channels()},
    {'icon': Icons.event, 'title': "Events", 'text': "Check upcoming events", "route": Channels()},
    {'icon': Icons.star, 'title': "Favorites", 'text': "Your favorite items", "route": Channels()},
    {'icon': Icons.lock, 'title': "Private", 'text': "Secure messages", "route": Channels()},
  ];

  final List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
    Colors.teal,
    Colors.pink,
  ];

  @override
  Widget build(BuildContext context) {
    const double spacing = 16.0;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TITLE
          const Text(
            "Welcome Prachi!",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),
          const SizedBox(height: 24),

          // FLEXIBLE CARDS
          Wrap(
            spacing: spacing,
            runSpacing: spacing,
            children: List.generate(cardData.length, (index) {
              return SizedBox(
                width: 200,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => cardData[index]['route'],
                        ),
                      );
                    },
                    child: CardWidget(
                      icon: cardData[index]['icon'],
                      title: cardData[index]['title'],
                      text: cardData[index]['text'],
                      color: colors[index % colors.length],
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
