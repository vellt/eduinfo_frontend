import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:eduinfo/services/api_service.dart' as apiUrl;

class InstitutionRegistrationNetwork {
  static Future<dynamic> registration(String email, String name, String password) async {
    var response = await http.post(
          Uri.parse(apiUrl.baseURL + "/auth/register"),
          headers: {"Content-type": "application/json"},
          body: json.encode({
            "email": email,
            "name": name,
            "password": password,
            "as": "institution",
          }),
        );
    return json.decode(response.body);
  }
}