import 'dart:convert';

import 'package:eduinfo/services/api_service.dart' as apiUrl;
import 'package:http/http.dart' as http;

class EditDescriptionNetwork {

  static Future<dynamic> updateDescription(String token, String description) async {
    var response = await http.put(
      Uri.parse(apiUrl.baseURL + '/institution/description'),
      headers: {"x-auth-token": token, "Content-type": "application/json"},
      body:json.encode({
        "description": description,
      }),
    );
    return json.decode(response.body);
  }
  
}