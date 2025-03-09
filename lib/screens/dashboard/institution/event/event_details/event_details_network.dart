import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:eduinfo/services/api_service.dart' as apiUrl;

class EventDetailsNetwork {
  static Future<dynamic> interest(String token, int eventId) async {
    var response = await http.post(
      Uri.parse(apiUrl.baseURL + '/person/event_interest/$eventId'),
      headers: {"x-auth-token": token},
    );
    return json.decode(response.body);
  }

  static Future<dynamic> unInterest(String token, int eventId) async {
    var response = await http.delete(
      Uri.parse(apiUrl.baseURL + '/person/event_interest/$eventId'),
      headers: {"x-auth-token": token},
    );
    return json.decode(response.body);
  } 
}