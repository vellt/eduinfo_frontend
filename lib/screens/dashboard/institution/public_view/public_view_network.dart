import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:eduinfo/services/api_service.dart' as apiUrl;

class PublicViewNetwork {
  static const Duration requestTimeout = Duration(seconds: 15);

  static Future<dynamic> getRole(String token) async {
    var response = await http.get(
      Uri.parse(apiUrl.baseURL + '/auth/role'),
      headers: {"x-auth-token": token},
    ).timeout(requestTimeout);
    return json.decode(response.body);
  }

  static Future<dynamic> getInstitution(String token, int institutionId) async {
    var response = await http.get(
      Uri.parse(apiUrl.baseURL + '/person/institutions/$institutionId'),
      headers: {"x-auth-token": token},
    ).timeout(requestTimeout);
    return json.decode(response.body);
  }

  static Future<dynamic> like(String token, int storyId) async {
    var response = await http.post(
      Uri.parse(apiUrl.baseURL + '/person/like_story/$storyId'),
      headers: {"x-auth-token": token},
    ).timeout(requestTimeout);
    return json.decode(response.body);
  }

  static Future<dynamic> unLike(String token, int storyId) async {
    var response = await http.delete(
      Uri.parse(apiUrl.baseURL + '/person/like_story/$storyId'),
      headers: {"x-auth-token": token},
    ).timeout(requestTimeout);
    return json.decode(response.body);
  }

  static Future<dynamic> follow(String token, int institutionId) async {
    var response = await http.post(
      Uri.parse(apiUrl.baseURL + '/person/follow_institution/$institutionId'),
      headers: {"x-auth-token": token},
    ).timeout(requestTimeout);
    return json.decode(response.body);
  }

  static Future<dynamic> unFollow(String token, int institutionId) async {
    var response = await http.delete(
      Uri.parse(apiUrl.baseURL + '/person/follow_institution/$institutionId'),
      headers: {"x-auth-token": token},
    ).timeout(requestTimeout);
    return json.decode(response.body);
  }
}