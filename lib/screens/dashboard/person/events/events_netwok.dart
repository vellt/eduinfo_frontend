import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:eduinfo/services/api_service.dart' as apiUrl;

class EventsNetwok {
  static Future<dynamic> getEvents(String token, bool interested) async {
    var response = await http.get(
      Uri.parse(apiUrl.baseURL + '/person/${interested?'interested_events':'events'}'),
      headers: {"x-auth-token": token},
    );
    return json.decode(response.body);
  }
}