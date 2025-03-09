import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:eduinfo/services/api_service.dart' as apiUrl;
import 'package:http_parser/http_parser.dart';

class SettingsNetwork {
  static Future<dynamic> updateEmail(String token, String email) async {
    var response = await http.put(
      Uri.parse(apiUrl.baseURL + '/person/email/'),
      headers: {"x-auth-token": token, "Content-type": "application/json"},
      body: json.encode({
        "email": email,
      }),
    );
    return json.decode(response.body);
  }

  static Future<dynamic> updateName(String token, String name) async {
    var response = await http.put(
      Uri.parse(apiUrl.baseURL + '/person/name/'),
      headers: {"x-auth-token": token, "Content-type": "application/json"},
      body: json.encode({
        "name": name,
      }),
    );
    return json.decode(response.body);
  }

  static Future<dynamic> updatePassword(String token, String oldPassword, String newPassword) async {
    var response = await http.put(
      Uri.parse(apiUrl.baseURL + '/person/password/'),
      headers: {"x-auth-token": token, "Content-type": "application/json"},
      body: json.encode({
        "current_password": oldPassword,
        "new_password": newPassword,
      }),
    );
    return json.decode(response.body);
  }

  static Future<dynamic> uploadAvatar(String token, String imagePath) async {
    var request = http.MultipartRequest('PUT', Uri.parse(apiUrl.baseURL + '/person/avatar/'))
      ..headers['x-auth-token'] = token
      ..files.add(await http.MultipartFile.fromPath('avatar_image', imagePath, contentType: MediaType('image', 'jpeg')));

    var response = await request.send();
    var responseData = await http.Response.fromStream(response);
    return json.decode(responseData.body);
  }

  static Future<dynamic> deleteProfile(String token) async {
    var response = await http.delete(
      Uri.parse(apiUrl.baseURL + '/person/profile/'),
      headers: {"x-auth-token": token},
    );
    return json.decode(response.body);
  }
}