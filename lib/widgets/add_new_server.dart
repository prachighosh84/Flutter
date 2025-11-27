import 'package:flutter/material.dart';
import 'package:m2i_cours_flutter/api/channels_api.dart';
import 'package:m2i_cours_flutter/models/channel_model.dart';
import 'package:m2i_cours_flutter/screens/navigation/features/add_channel.dart';

class AddNewChannelForm extends StatefulWidget {
  const AddNewChannelForm({super.key});

  @override
  State<AddNewChannelForm> createState() => _AddNewChannelFormState();
}

class _AddNewChannelFormState extends State<AddNewChannelForm> {
  final _formKey = GlobalKey<FormState>();
  final channelApiService = ChannelServiceApi();

  final TextEditingController name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        color: Colors.white70,
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,                    
                  ),
                borderRadius: BorderRadius.all(Radius.circular(6))
              ),
              child: Column(
                children: const [
                  Icon(
                    Icons.image,
                    color: Colors.black,
                    size: 24.0,
                    semanticLabel: 'image for server',
                  ),
                  Text('+ Add Image')
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
                 final response = await channelApiService.createServer(
                    name.text,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(response)),
                  );
                }
              },

              child: const Text('Done'),
            ),
          ],
        ),
      ),
    );
  }
}
