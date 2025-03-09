import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:eduinfo/services/api_service.dart' as apiUrl;

class InstitutionDetailsNetwork {
  static Future<dynamic> enableInstitution(String token, int id) async {
    var response = await http.put(
      Uri.parse(apiUrl.baseURL + '/admin/enable_institution/'+id.toString()),
      headers: {"x-auth-token": token},
    );
    print(response.body);
    return json.decode(response.body);
  }

  static Future<dynamic> disableInstitution(String token, int id) async {
    var response = await http.put(
      Uri.parse(apiUrl.baseURL + '/admin/disable_institution/'+id.toString()),
      headers: {"x-auth-token": token},
    );
    print(response.body);
    return json.decode(response.body);
  }

  static Future<dynamic> acceptInstitutiobRegistration(String token, int id) async {
    var response = await http.put(
      Uri.parse(apiUrl.baseURL + '/admin/accept_institution/'+id.toString()),
      headers: {"x-auth-token": token},
    );
    print(response.body);
    return json.decode(response.body);
  }
}