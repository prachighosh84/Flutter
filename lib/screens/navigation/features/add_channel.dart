
import 'package:flutter/material.dart';
import 'package:m2i_cours_flutter/widgets/add_new_server.dart';

class AddNewChannel extends StatefulWidget {
  const AddNewChannel({super.key});

  @override
  State<AddNewChannel> createState() => _AddNewChannelState();
}

class _AddNewChannelState extends State<AddNewChannel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Channel')),
      body: AddNewChannelForm(),
    );
  }
}
