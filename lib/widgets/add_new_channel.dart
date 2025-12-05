import 'package:flutter/material.dart';
import 'package:m2i_cours_flutter/api/channels_api.dart';
import 'package:m2i_cours_flutter/api/server_api.dart';
import 'package:provider/provider.dart';

import '../providers/server_provider.dart';


class AddNewChannelForm extends StatefulWidget {


  const AddNewChannelForm( {super.key});

  @override
  State<AddNewChannelForm> createState() => _AddNewChannelFormState();
}

class _AddNewChannelFormState extends State<AddNewChannelForm> {
  final _formKey = GlobalKey<FormState>();
  final channelApiService = ChannelServiceApi();

  final TextEditingController name = TextEditingController();
  @override
  Widget build(BuildContext context) {

    final selectedServer =  context.read<ServerProvider>().selectedServer;
    final serverId = selectedServer!.id;
    final serverName = selectedServer.name;
    print("server name : $serverName");

    return Form(
      key: _formKey,
      child: Container(
        color: Color(0xFF0f172b),
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("Server Name: ${serverName}", style: TextStyle(color: Colors.white70),),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(32.0),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white24,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(6))
              ),
              child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white70,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(6))
                  ),
                  child: Column(

                    children:  [
                      Icon(
                        Icons.image,
                        color: Colors.white70,
                        size: 24.0,
                        semanticLabel: 'image for channel',
                      ),
                      Text('+ Add Image', style: TextStyle(color: Colors.white70),)
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: name,
                  decoration: const InputDecoration(
                    hintText: "Enter channel name",
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter channel name';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final response = await channelApiService.createChannel(
                          name.text,
                          serverId
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(response)),
                      );
                    }
                  },

                  child: const Text('Done'),
                ),
              ]

              ),
            ),




          ],
        ),
      ),
    );
  }
}
