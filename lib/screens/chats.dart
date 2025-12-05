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

  Future<List<Message>>? messagesList;
  final messageApiService = ChatsServiceApi();

  @override
  void initState() {
    super.initState();

    final selectedChannel = context.read<ChannelProvider>().selectedChannel;

    // ✅ FIX: Prevent crash if no channel is selected
    if (selectedChannel == null) {
      print("⚠ ChatsPage opened before selecting a channel.");
      messagesList = null;
      return;
    }

    final channelId = selectedChannel.id;
    print("channel id for message: $channelId");

    messagesList = messageApiService.fetchMessages(channelId);
  }

  @override
  Widget build(BuildContext context) {

    final selectedChannel = context.watch<ChannelProvider>().selectedChannel;

    return Scaffold(
      backgroundColor: const Color(0xFF0f172b),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // HEADER
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              selectedChannel?.name ?? "Chats",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),

          // If no channel is selected → show placeholder
          if (selectedChannel == null)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/nochannels.png", width: 160),
                    const SizedBox(height: 20),
                    const Text(
                      "Select a channel to view messages",
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  ],
                ),
              ),
            )
          else
            Expanded(
              child: FutureBuilder<List<Message>>(
                future: messagesList,
                builder: (context, snapshot) {

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: const TextStyle(color: Colors.white70),
                      ),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/nochannels.png", width: 160),
                          const SizedBox(height: 20),
                          const Text(
                            "No messages in this channel yet",
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
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
            ),
        ],
      ),
    );
  }
}
