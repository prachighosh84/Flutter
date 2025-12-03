import 'package:flutter/material.dart';
import 'package:m2i_cours_flutter/models/channel_model.dart';
import 'package:m2i_cours_flutter/api/channels_api.dart';
import 'package:m2i_cours_flutter/screens/navigation/features/add_channel.dart';
import 'package:m2i_cours_flutter/widgets/add_new_channel.dart';

class ChannelsPage extends StatefulWidget {

 final  String serverId;
 final  String serverName;

 const ChannelsPage(this.serverId,this.serverName, {super.key});

  @override
  State<ChannelsPage> createState() => _ChannelsPageState();
}

class _ChannelsPageState extends State<ChannelsPage> {
  late Future<List<Channel>> channelsList;
  final channelApiService = ChannelServiceApi();



  @override
  void initState() {
    super.initState();
    print('serverid: ${widget.serverId}');
    channelsList = channelApiService.fetchChannels(widget.serverId); // call API
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
                  builder: (context) =>  AddNewChannel(widget.serverId, widget.serverName),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
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
