import 'package:flutter/material.dart';
import 'package:m2i_cours_flutter/api/channels_api.dart';
import 'package:m2i_cours_flutter/models/channel_model.dart';
import 'package:m2i_cours_flutter/screens/navigation/features/add_channel.dart';
import 'package:m2i_cours_flutter/screens/sign_in.dart';

class ChannelsPage extends StatefulWidget {
  const ChannelsPage({super.key});

  @override
  State<ChannelsPage> createState() => _ChannelsPageState();
}

class _ChannelsPageState extends State<ChannelsPage> {
  late Future<List<Channel>> channelsList;
  final channelApiService = ChannelServiceApi();

  @override
  void initState() {
    super.initState();
    channelsList = channelApiService.fetchChannels(); // call API
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Channels')),
      body: Column(
        children: [
          ElevatedButton(
            child: const Text('Add new channel'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) =>  AddNewChannel(),
                ),
              );
            },
          ),


          Expanded(
            child: FutureBuilder<List<Channel>>(
              future: channelsList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No channels available'));
                } else {
                  final channels = snapshot.data!;
                  return ListView.builder(
                    itemCount: channels.length,
                    itemBuilder: (context, index) {
                      final channel = channels[index];
                      return ListTile(
                        title: Text(channel.name),
                        onTap: () {
                          // TODO: Navigate to chat screen
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
