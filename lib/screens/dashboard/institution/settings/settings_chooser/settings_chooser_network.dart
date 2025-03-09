import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:eduinfo/services/api_service.dart' as apiUrl;

class SettingsChooserNetwork {
  static Future<dynamic> deleteProfile(String token) async {
    var response = await http.delete(
      Uri.parse(apiUrl.baseURL + '/institution/profile/'),
      headers: {"x-auth-token": token},
    );
    return json.decode(response.body);
  }
}