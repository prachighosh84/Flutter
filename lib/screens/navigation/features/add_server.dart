
import 'package:flutter/material.dart';
import 'package:m2i_cours_flutter/widgets/add_new_server.dart';

class AddNewServer extends StatefulWidget {
  const AddNewServer({super.key});

  @override
  State<AddNewServer> createState() => _AddNewServerState();
}

class _AddNewServerState extends State<AddNewServer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Server')),
      body: AddNewServerForm(),
    );
  }
}
