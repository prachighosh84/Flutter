import 'package:flutter/material.dart';
import 'package:m2i_cours_flutter/api/chats_api.dart';
import 'package:m2i_cours_flutter/models/message_model.dart';
import 'package:m2i_cours_flutter/providers/channel_provider.dart';
import 'package:m2i_cours_flutter/widgets/chat_item.dart';
import 'package:provider/provider.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {

  late Future<List<Message>> messagesList;
  final messageApiService = ChatsServiceApi();

  @override
  void initState() {
    super.initState();
    final selectedChannel = context.read<ChannelProvider>().selectedChannel;
    final channelId = selectedChannel!.id;
    print("channel id for message: $channelId");
    messagesList = messageApiService.fetchMessages(channelId);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF0f172b),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // HEADER
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

          // MAIN CONTENT → Expanded so it fills remaining space
          Expanded(
            child: FutureBuilder<List<Message>>(
              future: messagesList,
              builder: (context, snapshot) {

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: TextStyle(color: Colors.white70),
                    ),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(40),
                        child: Image.asset('assets/nochannels.png'),
                      ),
                      Text(
                        'No messages available',
                        style: TextStyle(color: Colors.white70),
                      )
                    ],
                  );
                }

                // MESSAGES LIST
                final messages = snapshot.data!;
                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return ChatItem(
                      userName: message.authorName,
                      message: message.content,
                      time: message.createdAt,
                      status: UserStatus.online,
                      avatarUrl: message.authorAvatarUrl,
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
