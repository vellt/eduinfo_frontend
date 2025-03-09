import 'dart:convert';

import 'package:eduinfo/services/api_service.dart' as apiUrl;
import 'package:eduinfo/models/public_phone.dart';
import 'package:http/http.dart' as http;

class EditPhoneNetwork {

  static Future<dynamic> updatePhone(String token, PublicPhone phone) async {
    var response = await http.put(
      Uri.parse(apiUrl.baseURL + '/institution/public/phone/${phone.id}'),
      headers: {"x-auth-token": token, "Content-type": "application/json"},
      body: json.encode({
        "title": phone.title,
        "phone": phone.phone,
      }),
    );
    return json.decode(response.body);
  }

  static Future<dynamic> createPhone(String token, PublicPhone phone) async {
    var response = await http.post(
      Uri.parse(apiUrl.baseURL + '/institution/public/phone'),
      headers: {"x-auth-token": token, "Content-type": "application/json"},
      body:json.encode({
        "title": phone.title,
        "phone": phone.phone,
      }),
    );
    return json.decode(response.body);
  }

  static Future<dynamic> deletePhone(String token, PublicPhone phone) async {
    var response = await http.delete(
      Uri.parse(apiUrl.baseURL + '/institution/public/phone/${phone.id}'),
      headers: {"x-auth-token": token, "Content-type": "application/json"},
    );
    return json.decode(response.body);
  }
}