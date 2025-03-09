import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:eduinfo/services/api_service.dart' as apiUrl;

class MessageDetailsNetwork {
  static Future<dynamic> findMessagingRoom(String token, int institutionId) async {
    var response = await http.get(
      Uri.parse(apiUrl.baseURL + '/person/find_messaging_rooms/$institutionId'),
      headers: {"x-auth-token": token},
    );
    return json.decode(response.body);
  }

  static Future<dynamic> sendMessage(int institutionId,String message,String token) async {
    var response = await http.post(
      Uri.parse(apiUrl.baseURL + '/person/send_message/$institutionId'),
      headers: {"Content-type": "application/json", "x-auth-token": token},
      body: json.encode({
        "message": message,
      }),
    );
    return json.decode(response.body);
  }

  static Future<dynamic> getMessagesVersionById(String token, int messagingRoomId) async {
    var response = await http.get(
      Uri.parse(apiUrl.baseURL + '/person/messages_version/$messagingRoomId'),
      headers: {"x-auth-token": token},
    );
    return json.decode(response.body);
  }
}