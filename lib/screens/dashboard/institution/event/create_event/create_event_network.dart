import 'dart:convert';

import 'package:eduinfo/models/event_link.dart';
import 'package:http/http.dart' as http;
import 'package:eduinfo/services/api_service.dart' as apiUrl;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class CreateEventNetwork {
  static Future<dynamic> createEvent({required String token, XFile? image,required DateTime eventStart,required DateTime eventEnd,required String title,required String location,required String description,required List<EventLink>links}) async {
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl.baseURL + '/institution/event/'))
      ..headers['x-auth-token'] = token
      ..fields.addAll({
        'event_start': eventStart.toIso8601String(),
        'event_end': eventEnd.toIso8601String(),
        'title': title,
        'location': location,
        'description': description,
        'event_links':jsonEncode(links.map((link) => link.toJson()).toList()),
    });
    if(image!=null){
      request.files.add(await http.MultipartFile.fromPath('banner_image', image.path, contentType: MediaType('image', 'jpeg')));
    }
    var response = await request.send();
    var responseData = await http.Response.fromStream(response);
    return json.decode(responseData.body);
  }
}