import 'dart:convert';
import 'package:m2i_cours_flutter/api/api_urls.dart';

import '../models/server_model.dart';
import 'package:http/http.dart' as http;

class ServerServiceApi {

//https://us-central1-messaging-backend-m2i.cloudfunctions.net/api/channels?userId=123
  Future<List<Server>> fetchServers() async {
    final baseUrl = ApiUrls.baseUrl;
    final url = Uri.parse('$baseUrl/servers?userId=53Fphd4xy9bRzfVUUqzG10tZqej1');



    final response = await http.get(url, headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final Map<String, dynamic> decoded = jsonDecode(response.body);
      final List data = decoded['servers'];
      return data.map((json) => Server.fromJson(json)).toList();
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

    if (response.statusCode == 200 || response.statusCode == 201) {
      return "Server Created Successfully!";
    } else {
      return "Error: ${response.body}";
    }
  }


  Future<String> generateInviteLink(String serverId) async {
    final baseUrl = ApiUrls.baseUrl;

    final url = Uri.parse('$baseUrl/servers/$serverId/invite');

    final body = jsonEncode({
      "serverId": serverId,
      "inviterId": "53Fphd4xy9bRzfVUUqzG10tZqej1",
    });

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["inviteLink"] ?? "No invite link returned";
    } else {
      throw Exception("Failed to generate invite link: ${response.body}");
    }
  }
}
