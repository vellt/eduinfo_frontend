import 'dart:convert';

import 'package:eduinfo/services/api_service.dart' as apiUrl;
import 'package:eduinfo/models/public_website.dart';
import 'package:http/http.dart' as http;

class EditWebsiteNetwork {
  static Future<dynamic> updateWebsite(String token, PublicWebsite website) async {
    var response = await http.put(
      Uri.parse(apiUrl.baseURL + '/institution/public/website/${website.id}'),
      headers: {"x-auth-token": token, "Content-type": "application/json"},
      body:json.encode({
        "title": website.title,
        "website": website.website,
      }),
    );
    return json.decode(response.body);
  }

  static Future<dynamic> createWebsite(String token, PublicWebsite website) async {
    var response = await http.post(
      Uri.parse(apiUrl.baseURL + '/institution/public/website'),
      headers: {"x-auth-token": token, "Content-type": "application/json"},
      body: json.encode({
        "title": website.title,
        "website": website.website,
      }),
    );
    return json.decode(response.body);
  }

  static Future<dynamic> deleteWebsite(String token, PublicWebsite website) async {
    var response = await http.delete(
      Uri.parse(apiUrl.baseURL + '/institution/public/website/${website.id}'),
      headers: {"x-auth-token": token, "Content-type": "application/json"},
    );
    return json.decode(response.body);
  }
}