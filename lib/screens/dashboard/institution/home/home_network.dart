import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:eduinfo/services/api_service.dart' as apiUrl;

class HomeNetwork {
  static Future<dynamic> logout(String token) async {
    var response = await http.put(
      Uri.parse(apiUrl.baseURL + '/auth/logout'),
      headers: {"x-auth-token": token},
    );
    return json.decode(response.body);
  }

  static Future<dynamic> getProfile(String token) async {
    var response = await http.get(
      Uri.parse(apiUrl.baseURL + '/institution/profile'),
      headers: {"x-auth-token": token},
    );
    return json.decode(response.body);
  }

  static Future<dynamic> deleteStory(String token, int id) async {
    var response = await http.delete(
      Uri.parse(apiUrl.baseURL + '/institution/story/'+id.toString()),
      headers: {"x-auth-token": token},
    );
    return json.decode(response.body);
  }

  static Future<dynamic> deleteEvents(String token, int id) async {
    var response = await http.delete(
      Uri.parse(apiUrl.baseURL + '/institution/event/'+id.toString()),
      headers: {"x-auth-token": token},
    );
    return json.decode(response.body);
  }

  static Future<dynamic> getMessagingRooms(String token) async {
    var response = await http.get(
      Uri.parse(apiUrl.baseURL + '/institution/messaging_rooms'),
      headers: {"x-auth-token": token},
    );
    return json.decode(response.body);
  }

  static Future<dynamic> getMessagesVersion(String token) async {
    var response = await http.get(
      Uri.parse(apiUrl.baseURL + '/institution/messages_version'),
      headers: {"x-auth-token": token},
    );
    return json.decode(response.body);
  }

  
}