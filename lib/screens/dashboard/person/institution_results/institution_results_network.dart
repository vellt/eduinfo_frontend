import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:eduinfo/services/api_service.dart' as apiUrl;

class InstitutionResultsNetwork {
  static getInstitutions(String token, int categoryId)async {
    var response = await http.get(
      Uri.parse(apiUrl.baseURL + '/person/institutions_by_category/$categoryId'),
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
}