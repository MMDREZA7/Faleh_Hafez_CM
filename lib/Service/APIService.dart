import 'dart:convert';
import 'dart:ffi';

import 'package:faleh_hafez/domain/user.dart';
import 'package:faleh_hafez/domain/user_chat.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "http://130.185.76.18:3030";

  // Example for GET request
  Future<String> registerUser(String mobileNumber, String password) async {
    final url = Uri.parse('$baseUrl/api/Authentication/Register');

    try {
      var bodyRequest = {"mobileNumber": mobileNumber, "password": password};

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(bodyRequest),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception(response.body);
      }
    } catch (e) {
      rethrow;
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
        throw Exception(response.body);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<UserChatItem>> getUsersChat({required String token}) async {
    final url = Uri.parse('$baseUrl/api/Chat/GetUserChats');

    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        var bodyContent = json.decode(response.body);

        final List<UserChatItem> userChatItems = [];

        for (var item in bodyContent) {
          userChatItems.add(
            UserChatItem(
              id: item['id'],
              participant1ID: item['participant1ID'],
              participant1MobileNumber: item['participant1MobileNumber'],
              participant2ID: item['participant2ID'],
              participant2MobileNumber: item['participant2MobileNumber'],
              lastMessageTime: item['lastMessageTime'],
            ),
          );
        }

        return userChatItems;
      } else {
        throw Exception(response.body);
      }
    } catch (e) {
      rethrow;
    }
  }
}
