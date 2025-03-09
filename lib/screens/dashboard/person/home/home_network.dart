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

  static Future<dynamic> getHome(String token) async {
    var response = await http.get(
      Uri.parse(apiUrl.baseURL + '/person/home'),
      headers: {"x-auth-token": token},
    );
    return json.decode(response.body);
  }

  static Future<dynamic> getCategories() async {
    var response = await http.get(Uri.parse(apiUrl.baseURL + '/person/categories'));
    return json.decode(response.body);
  }

  static Future<dynamic> getMessagingRooms(String token) async {
    var response = await http.get(
      Uri.parse(apiUrl.baseURL + '/person/messaging_rooms'),
      headers: {"x-auth-token": token},
    );
    return json.decode(response.body);
  }

  static Future<dynamic> getProfile(String token) async {
    var response = await http.get(
      Uri.parse(apiUrl.baseURL + '/person/profile'),
      headers: {"x-auth-token": token},
    );
    return json.decode(response.body);
  }

  static Future<dynamic> getMessagesVersion(String token) async {
    var response = await http.get(
      Uri.parse(apiUrl.baseURL + '/person/messages_version'),
      headers: {"x-auth-token": token},
    );
    return json.decode(response.body);
  }

  static Future<dynamic> getHomeVersion(String token) async {
    var response = await http.get(
      Uri.parse(apiUrl.baseURL + '/person/home_version'),
      headers: {"x-auth-token": token},
    );
    return json.decode(response.body);
  }

  static Future<dynamic> getFollowesVersion(String token) async {
    var response = await http.get(
      Uri.parse(apiUrl.baseURL + '/person/followes_version'),
      headers: {"x-auth-token": token},
    );
    return json.decode(response.body);
  }

  static Future<dynamic> getFollowes(String token) async {
    var response = await http.get(
      Uri.parse(apiUrl.baseURL + '/person/followes'),
      headers: {"x-auth-token": token},
    );
    return json.decode(response.body);
  }

  static Future<dynamic> like(String token, int storyId) async {
    var response = await http.post(
      Uri.parse(apiUrl.baseURL + '/person/like_story/$storyId'),
      headers: {"x-auth-token": token},
    );
    return json.decode(response.body);
  }

  static Future<dynamic> unLike(String token, int storyId) async {
    var response = await http.delete(
      Uri.parse(apiUrl.baseURL + '/person/like_story/$storyId'),
      headers: {"x-auth-token": token},
    );
    return json.decode(response.body);
  }
}