import 'dart:convert';
import 'dart:io';

import 'package:eduinfo/models/event_link.dart';
import 'package:http/http.dart' as http;
import 'package:eduinfo/services/api_service.dart' as apiUrl;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class EditEventNetwork {
  static Future<XFile?> downloadImageAndCreateXFile(String imageUrl) async {
     final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      // Helyi ideiglenes mappa elérése
      final tempDir = await getTemporaryDirectory();
      final filePath = '${tempDir.path}/${imageUrl.split('/').last}';

      // A fájl mentése a helyi tárolóba
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);

      // XFile létrehozása a letöltött fájlból
      return XFile(filePath);
    } else {
      print('Failed to download image. Status code: ${response.statusCode}');
      return null;
    }
  }

  static Future<dynamic> updateEvent({required id,required String token, XFile? image,required DateTime eventStart,required DateTime eventEnd,required String title,required String location,required String description,required List<EventLink>links}) async {
    var request = http.MultipartRequest('PUT', Uri.parse(apiUrl.baseURL + '/institution/event/$id'))
      ..headers['x-auth-token'] = token
      ..fields.addAll({
        'event_id':id.toString(),
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