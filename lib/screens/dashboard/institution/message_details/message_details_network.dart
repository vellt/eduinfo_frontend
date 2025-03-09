import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:eduinfo/services/api_service.dart' as apiUrl;

class MessageDetailsNetwork {
  static Future<dynamic> getMessagingRooms(int id, String token) async {
    var response = await http.get(
      Uri.parse(apiUrl.baseURL + '/institution/messaging_rooms/$id'),
      headers: {"x-auth-token": token},
    );
    return json.decode(response.body);
  }

  static Future<dynamic> sendMessage(int personId,String message,String token) async {
    var response = await http.post(
      Uri.parse(apiUrl.baseURL + '/institution/send_message/$personId'),
      headers: {"Content-type": "application/json", "x-auth-token": token},
      body: json.encode({
        "message": message,
      }),
    );
    return json.decode(response.body);
  }

  static Future<dynamic> getMessagesVersionById(String token, int messagingRoomId) async {
    var response = await http.get(
      Uri.parse(apiUrl.baseURL + '/institution/messages_version/$messagingRoomId'),
      headers: {"x-auth-token": token},
    );
    return json.decode(response.body);
  }
}