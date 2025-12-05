import 'package:flutter/material.dart';
import 'package:m2i_cours_flutter/api/channels_api.dart';
import 'package:m2i_cours_flutter/api/chats_api.dart';
import 'package:m2i_cours_flutter/api/server_api.dart';
import 'package:m2i_cours_flutter/models/channel_model.dart';
import 'package:m2i_cours_flutter/models/message_model.dart';
import 'package:m2i_cours_flutter/models/server_model.dart';
import 'package:m2i_cours_flutter/screens/channels.dart';
import 'package:m2i_cours_flutter/screens/chats.dart';
import 'package:m2i_cours_flutter/screens/profile.dart';
import 'package:m2i_cours_flutter/widgets/chatInput.dart';
import 'package:m2i_cours_flutter/widgets/icon_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? userDisplay = '';
  late Future<List<Message>> messageList;

  late Server selectedServer;


  late List<Server> servers;
  int serverCount = 0;
  late Future<List<Channel>> channelList;
  late Future<List<Server>> serverList;


  @override
  void initState() {
    super.initState();
    getUserSharedPref();
    getRecentMessages();
  }

  Future<void> getRecentMessages() async{
    final serverApiService = ServerServiceApi();
    final channelServiceApi = ChannelServiceApi();
    final messageApiService = ChatsServiceApi();

    serverList = serverApiService.fetchServers(); // assign Future<List<Server>>
    serverApiService.fetchServers().then((servers) {
      if (servers.isNotEmpty) {
        selectedServer= servers[0];
        print('First server: ${selectedServer.name}, id: ${selectedServer.id}');
      } else {
        print('No servers available');
      }
    }).catchError((e) {
      print('Error fetching servers: $e');
    });
    //messageList = messageApiService.fetchMessages(channelId);
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
        'page': const ChatsPage(),
      },
      {
        'title': 'Notifications',
        'subtitle': 'View notifications',
        'icon': Icons.notifications,
        'page': const ChatsPage(),
      },
      {
        'title': 'Favourites',
        'subtitle': 'Your Favorites',
        'icon': Icons.settings,
        'page': const ChatsPage(),
      },
      {
        'title': 'Settings',
        'subtitle': 'Edit Settings',
        'icon': Icons.settings,
        'page': const ChatsPage(),
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0f172b),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: ChatInput(
            onSend: (message) {
              print("User sent: $message");
            },
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 16),
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
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
                child:

                Text("Recent Chats", style: TextStyle(color: Colors.white70),)

              ),
            ],
          ),
        ),
      ),
    );

  }
}
