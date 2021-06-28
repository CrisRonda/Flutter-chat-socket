import 'package:chat_app_sockets/models/message_response.dart';
import 'package:chat_app_sockets/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:chat_app_sockets/models/user.dart';
import 'package:chat_app_sockets/global/enviroments.dart';

class ChatService with ChangeNotifier {
  late User userReceive;

  Future<List<Message>> getChat(String uidReceiver) async {
    final resp = await http.get(
        Uri.parse('${Enviroments.apiURL}/messages/$uidReceiver'),
        headers: {
          'Content-type': 'application/json',
          'x-token': await AuthService.getToken(),
        });
    final messagesResponse = messagesResponseFromJson(resp.body);
    if (messagesResponse.ok) {
      return messagesResponse.messages;
    }
    return [];
  }
}
