import 'dart:convert';
import '../models/channel_model.dart';
import 'package:http/http.dart' as http;

class ChannelServiceApi {
  Future<List<Channel>> fetchChannels(String serverId) async {
    final url = Uri.parse(
      'https://us-central1-messaging-backend-m2i.cloudfunctions.net/api/servers/$serverId/channels',
    );

    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    print("channels-----: ${response.body}");

    if (response.statusCode == 200) {
      // RESPONSE IS A LIST, NOT A MAP
      final List<dynamic> list = jsonDecode(response.body);

      return list
          .map((json) => Channel.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to fetch channels: ${response.statusCode}');
    }
  }


  Future<String> createChannel(String name, String serverId) async {
    final url = Uri.parse(
      "https://us-central1-messaging-backend-m2i.cloudfunctions.net/api/servers/$serverId/channels",
    );

    print('url: $url');

    final body = jsonEncode({
      "name": name,
      "userId": "53Fphd4xy9bRzfVUUqzG10tZqej1",
    });

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,

    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    } else {
      throw Exception(
        "Failed to create channel: ${response.statusCode} - ${response.body}",
      );
    }
  }


}
