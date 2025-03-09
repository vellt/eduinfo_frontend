import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:eduinfo/services/api_service.dart' as apiUrl;

class FollowingListNetwork {
  static Future<dynamic> getProfile(String token) async {
    var response = await http.get(
      Uri.parse(apiUrl.baseURL + '/person/profile'),
      headers: {"x-auth-token": token},
    );
    return json.decode(response.body);
  }

  
}