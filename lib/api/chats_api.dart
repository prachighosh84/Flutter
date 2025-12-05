import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/message_model.dart';
import 'api_urls.dart';

class ChatsServiceApi {
  final baseUrl = ApiUrls.baseUrl;
  Future<List<Message>> fetchMessages(String channelId) async {
    final url = Uri.parse(
      '$baseUrl/channels/$channelId/messages',
    );

    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    print("messages-----: ${response.body}");

    if (response.statusCode == 200) {
      // RESPONSE IS A LIST, NOT A MAP
      final List<dynamic> list = jsonDecode(response.body);

      return list
          .map((json) => Message.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to fetch channels: ${response.statusCode}');
    }
  }


  Future<String> createMessage(String name, String channelId) async {
    final url = Uri.parse(
      "$baseUrl/channels/$channelId/messages",
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
        "Failed to create message: ${response.statusCode} - ${response.body}",
      );
    }
  }
}
