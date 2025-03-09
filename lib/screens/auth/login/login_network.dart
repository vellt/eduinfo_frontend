import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:eduinfo/services/api_service.dart' as apiUrl;

class LoginNetwork {
  static Future<dynamic> sendLogin(String email,String password) async {
    var response = await http.post(
      Uri.parse(apiUrl.baseURL + "/auth/standard_login"),
      headers: {"Content-type": "application/json"},
      body: json.encode({
        "email": email,
        "password": password,
      }),
    );
    return json.decode(response.body);
  }

  static Future<dynamic> getRole(String token) async {
    var response = await http.get(
      Uri.parse(apiUrl.baseURL + '/auth/role'),
      headers: {"x-auth-token": token},
    );
    return json.decode(response.body);
  }
}