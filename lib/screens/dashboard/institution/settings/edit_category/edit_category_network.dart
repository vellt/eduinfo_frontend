import 'dart:convert';

import 'package:eduinfo/services/api_service.dart' as apiUrl;
import 'package:http/http.dart' as http;

class EditCategoryNetwork {
  static Future<dynamic> getCategories() async {
    var response = await http.get(Uri.parse(apiUrl.baseURL + '/institution/categories'));
    return json.decode(response.body);
  }

  static Future<dynamic> updateCategories(String token, List<Map<String, dynamic>> categories) async {
    var response = await http.put(
      Uri.parse(apiUrl.baseURL + '/institution/institution_categories'),
      headers: {"x-auth-token": token, "Content-type": "application/json"},
      body:json.encode({
        "categories": categories,
      }),
    );
    return json.decode(response.body);
  }
}