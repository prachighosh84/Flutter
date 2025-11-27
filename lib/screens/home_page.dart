import 'package:flutter/material.dart';
import 'package:m2i_cours_flutter/screens/channels.dart';
import 'package:m2i_cours_flutter/screens/chats.dart';
import 'package:m2i_cours_flutter/screens/profile.dart';
import 'package:m2i_cours_flutter/widgets/icon_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? userDisplay = '';

  @override
  void initState() {
    super.initState();
    getUserSharedPref();
  }

  Future<void> getUserSharedPref() async {
    final userPref = await SharedPreferences.getInstance();
    final display = await userPref.getString('userDisplay');
    setState(() {
      userDisplay = display;
    });
  }

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
        'subtitle': 'View notifications',
        'icon': Icons.notifications,
        'page': const ChannelsPage(),
      },
      {
        'title': 'Favourites',
        'subtitle': 'Your Favorites',
        'icon': Icons.settings,
        'page': const ChannelsPage(),
      },
      {
        'title': 'Settings',
        'subtitle': 'Edit Settings',
        'icon': Icons.settings,
        'page': const ChannelsPage(),
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0f172b),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 8), // prevent tiny overflow
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Welcome $userDisplay",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Text(
                  "Here's a summary of your activity!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: cardData.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 1.5,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
