import 'dart:convert';

import 'package:faleh_hafez/domain/user.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "http://130.185.76.18:3030";

  // Example for GET request
  Future<String> registerUser(String mobileNumber, String password) async {
    final url = Uri.parse('$baseUrl/api/Autentication/Register');
    var bodyRequest = {
      "id": "71ce376c-5a68-4e3b-c251-08dd107067d5",
      "mobileNumber": "09120000001",
      "token": '',
      "type": ''
    };
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({bodyRequest}),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return;
      } else {
        print("Failed to post data: ${response.statusCode}");
        throw Exception("Failed to post data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
      throw Exception("Error: $e");
    }
  }

  Future<User> loginUser(String mobileNumber, String password) async {
    final url = Uri.parse('$baseUrl/api/Authentication/Login');
    try {
      var bodyRequest = {"mobileNumber": mobileNumber, "password": password};

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(bodyRequest),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        var bodyContent = json.decode(response.body);
        var user = User(
          id: bodyContent["id"],
          mobileNumber: bodyContent["mobileNumber"],
          token: bodyContent["token"],
          type: bodyContent["type"],
        );
        return user;
      } else {
        throw Exception("Failed to post data: ${response.statusCode}");
      }
    } catch (e) {
      rethrow;
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
