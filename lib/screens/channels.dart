import 'package:flutter/material.dart';
import 'package:m2i_cours_flutter/models/channel_model.dart';
import 'package:m2i_cours_flutter/api/channels_api.dart';
import 'package:m2i_cours_flutter/providers/server_provider.dart';
import 'package:m2i_cours_flutter/providers/channel_provider.dart';
import 'package:m2i_cours_flutter/screens/chats.dart';
import 'package:m2i_cours_flutter/screens/navigation/features/add_channel.dart';
import 'package:provider/provider.dart';

class ChannelsPage extends StatefulWidget {

 const ChannelsPage( {super.key});

  @override
  State<ChannelsPage> createState() => _ChannelsPageState();
}

class _ChannelsPageState extends State<ChannelsPage> {
  late Future<List<Channel>> channelsList;
  final channelApiService = ChannelServiceApi();
  late var serverId = "";
  late var serverName = "";


  @override
  void initState() {
    super.initState();
    final selectedServer =  context.read<ServerProvider>().selectedServer;
    serverId = selectedServer!.id;
    serverName = selectedServer.name;
    channelsList = channelApiService.fetchChannels(serverId); // call API
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0f172b),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white70
        ),

        title: Text('Channels',

        style: TextStyle(color: Colors.white),),
        backgroundColor:  const Color(0xFF0f172b),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) =>  AddNewChannel(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Text("Server Name: ${serverName}", style: TextStyle(color: Colors.white70),),
          Expanded(
            child: FutureBuilder<List<Channel>>(
              future: channelsList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.white70),));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {

                  return Column(
                    children: [
                      Center(
                        child:Padding(
                            padding: EdgeInsets.only(top: 60, left:40, right: 40, bottom: 40),
                            child: Image.asset('assets/nochannels.png'),
                          ),
                      ),
                      Text('No channels available', style: TextStyle(color: Colors.white70),)
                    ],

                  );
                } else {
                  final channels = snapshot.data!;
                  return Column(
                    children: [
                      Expanded(child:  ListView.builder(
                        itemCount: channels.length,
                        itemBuilder: (context, index) {
                          final channel = channels[index];
                          return ListTile(
                            title:Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Colors.white10, width: 1), ),
                              ),
                              child:
                              Row(
                                children: [
                                  Icon(Icons.tag),
                                  Text(channel.name, style: TextStyle(color: Colors.white),),
                                ],

                              ),
                            ) ,
                            onTap: () {
                              context.read<ChannelProvider>().setSelectedChannel(channel);
                              final selectedChannel = context.read<ChannelProvider>().selectedChannel;
                              print("selected channel name: ${selectedChannel?.name}");

                              print("selected channel id: ${selectedChannel?.id}");

                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (context) =>  ChatsPage(),
                                ),
                              );
                              // TODO: Navigate to chat screen
                            },
                          );
                        },
                      ))
                    ],
                  ) ;
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
