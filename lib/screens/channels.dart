import 'package:flutter/material.dart';
import 'package:m2i_cours_flutter/api/channels_api.dart';
import 'package:m2i_cours_flutter/models/channel_model.dart';
import 'package:m2i_cours_flutter/screens/navigation/features/add_channel.dart';

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
      backgroundColor: const Color(0xFF0f172b),
      appBar: AppBar(title: Text('Channels',
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
          Container(
            padding:EdgeInsets.only(top:0, left: 16, bottom: 8),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey,  // border color
                  width: 1.0,          // border thickness
                ),
              ),
            ),
            child: Row(
                children: [
                  InputChip(
                      onPressed: () {},
                      label: Text("Recents"),
                    // Border styling
                    shape: StadiumBorder(
                      side: BorderSide(
                        color: Colors.white,  // border color
                        width: 1.5,          // border width
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  InputChip(
                      onPressed: () {},
                      label: Text("Unread"),
                    shape: StadiumBorder(
                      side: BorderSide(
                        color: Colors.white,  // border color
                        width: 1.5,          // border width
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  InputChip(
                    onPressed: () {},
                    label: Text("Favourites"),
                    shape: StadiumBorder(
                      side: BorderSide(
                        color: Colors.white,  // border color
                        width: 1.5,          // border width
                      ),
                    ),
                  ),
                ]
            ),
            
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
