import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8000 '; // Replace with your FastAPI server URL  // For Android emulator: 10.0.2.2
  // For Chrome/web: use your machine IP, e.g. http://192.168.1.5:8000

  static Future<Map<String, dynamic>> signup({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse("$baseUrl/signup");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if ( response statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to sign up: ${response.body}');
    }
  }
}
