import 'dart:convert';
import '../models/channel_model.dart';
import 'package:http/http.dart' as http;

class ChannelServiceApi {

//https://us-central1-messaging-backend-m2i.cloudfunctions.net/api/channels?userId=123
  Future<List<Channel>> fetchChannels() async {
    final url = Uri.parse('https://us-central1-messaging-backend-m2i.cloudfunctions.net/api/servers?userId=53Fphd4xy9bRzfVUUqzG10tZqej1');
    final response = await http.get(url, headers: {'Content-Type': 'application/json'});

    print('Status Code: ${response.statusCode}');
    print('Body: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> decoded = jsonDecode(response.body);
      final List data = decoded['servers'];
      return data.map((json) => Channel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch channels');
    }
  }


  Future<String> createServer(String name) async {
    final url = Uri.parse("https://us-central1-messaging-backend-m2i.cloudfunctions.net/api/servers");

    final body = jsonEncode({
      "name": name,
      "ownerId": "53Fphd4xy9bRzfVUUqzG10tZqej1",
    });

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    print("Status: ${response.statusCode}");
    print("Body: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      return "Server Created Successfully!";
    } else {
      return "Error: ${response.body}";
    }
  }


}
