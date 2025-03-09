import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:eduinfo/services/api_service.dart' as apiUrl;

class NotAcceptedUserNetwork {
  static Future<dynamic> logout(String token) async {
    var response = await http.put(
      Uri.parse(apiUrl.baseURL + '/auth/logout'),
      headers: {"x-auth-token": token},
    );
    return json.decode(response.body);
  }

  static Future<dynamic> checkAccepted(String token, String role) async {
    var response = await http.get(
      Uri.parse(apiUrl.baseURL + '$role/accepted'),
      headers: {"x-auth-token": token},
    );
    return json.decode(response.body);
  }
}