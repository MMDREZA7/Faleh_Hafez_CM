import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "http://130.185.76.18:3030";

  // Example for GET request
  Future<dynamic> registerUser(String mobileNumber, String password) async {
    final url = Uri.parse('$baseUrl/api/Autentication/Register');
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({mobileNumber, password}),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return response.body;
      } else {
        print("Failed to post data: ${response.statusCode}");
        throw Exception("Failed to post data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
      throw Exception("Error: $e");
    }
  }

  Future<dynamic> loginUser(String mobileNumber, String password) async {
    final url = Uri.parse('$baseUrl/api/Autentication/Login');
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({mobileNumber, password}),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return response.body;
      } else {
        print("Failed to post data: ${response.statusCode}");
        throw Exception("Failed to post data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
      throw Exception("Error: $e");
    }
  }

  // Example for POST request
  Future<dynamic> postData(String endpoint, Map<String, dynamic> data) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(data),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception("Failed to post data: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
