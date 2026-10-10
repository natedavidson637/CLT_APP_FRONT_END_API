import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8000'; // Replace with your FastAPI server URL  // For Android emulator: 10.0.2.2
  // For Chrome/web: use your machine IP, e.g. http://192.168.1.5:8000

  static Future<Map<String, dynamic>> signup({
    required String username,
    required String password,
    required int age,
    required String location,
  }) async {
    final url = Uri.parse("$baseUrl/auth/signup");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": username,
        "password": password,
        "age": age,
        "location": location,
        "admin": false,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to sign up: ${response.body}');
    }
  }

  static Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    final url = Uri.parse("$baseUrl/auth/login");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"username": username, "password": password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Login failed: ${response.body}');
    }
  }

  static Future<List<dynamic>> getFeed() async {
    final url = Uri.parse("$baseUrl/events/feed");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load feed: ${response.body}");
    }
  }

  static Future<Map<String, dynamic>> rsvp({
    required int eventId,
    required String token,
  }) async {
    final url = Uri.parse("$baseUrl/events/$eventId/rsvp");

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("RSVP failed: ${response.body}");
    }
  }
}
