import 'dart:convert';

import 'package:eduinfo/services/api_service.dart' as apiUrl;
import 'package:eduinfo/models/public_email.dart';
import 'package:http/http.dart' as http;

class EditEmailNetwork {

  static Future<dynamic> updateEmail(String token, PublicEmail email) async {
    var response = await http.put(
      Uri.parse(apiUrl.baseURL + '/institution/public/email/${email.id}'),
      headers: {"x-auth-token": token, "Content-type": "application/json"},
      body:json.encode({
        "title": email.title,
        "email": email.email,
      }),
    );
    return json.decode(response.body);
  }

  static Future<dynamic> createEmail(String token, PublicEmail email) async {
    var response = await http.post(
      Uri.parse(apiUrl.baseURL + '/institution/public/email'),
      headers: {"x-auth-token": token, "Content-type": "application/json"},
      body:json.encode({
        "title": email.title,
        "email": email.email,
      }),
    );
    return json.decode(response.body);
  }

  static Future<dynamic> deleteEmail(String token, PublicEmail email) async {
    var response = await http.delete(
      Uri.parse(apiUrl.baseURL + '/institution/public/email/${email.id}'),
      headers: {"x-auth-token": token, "Content-type": "application/json"},
    );
    return json.decode(response.body);
  }

}