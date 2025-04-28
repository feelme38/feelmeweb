import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl;
  final http.Client _client;

  ApiClient({required this.baseUrl}) : _client = http.Client();

  Future<dynamic> get(String path) async {
    final response = await _client.get(Uri.parse('$baseUrl$path'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  void dispose() {
    _client.close();
  }
}
