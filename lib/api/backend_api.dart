import 'dart:convert';
import 'package:http/http.dart' as http;

// This class will handle all API requests
class BackendApiService {
  final String baseUrl ; // Your backend API base URL

  BackendApiService({required this.baseUrl});

  // GET request
  Future<http.Response> get(String endpoint) async {
    final url = Uri.parse('$baseUrl$endpoint');
    return await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        // add Authorization here later
      },
    );
  }

  // POST request
  Future<http.Response> post(String endpoint, Map<String, dynamic> data) async {
    final url = Uri.parse('$baseUrl$endpoint');
    return await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
  }

// You can also add PUT, DELETE if needed
}
