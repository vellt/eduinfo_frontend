import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:eduinfo/services/api_service.dart' as apiUrl;

class PersonDetailsNetwork {
  static Future<dynamic> enablePerson(String token, int id) async {
    var response = await http.put(
      Uri.parse(apiUrl.baseURL + '/admin/enable_person/'+id.toString()),
      headers: {"x-auth-token": token},
    );
    return json.decode(response.body);
  }

  static Future<dynamic> disablePerson(String token, int id) async {
    var response = await http.put(
      Uri.parse(apiUrl.baseURL + '/admin/disable_person/'+id.toString()),
      headers: {"x-auth-token": token},
    );
    return json.decode(response.body);
  }

}