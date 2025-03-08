import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:8888';

  Future<String> fetchMessage() async {
    final response = await http.get(Uri.parse('$baseUrl/hello'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['message'];
    } else {
      throw Exception('Failed to load data');
    }
  }
}
