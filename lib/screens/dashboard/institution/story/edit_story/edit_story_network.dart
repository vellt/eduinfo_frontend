import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:eduinfo/services/api_service.dart' as apiUrl;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class EditStoryNetwork {
  static Future<XFile?> downloadImageAndCreateXFile(String imageUrl) async {
     final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      final tempDir = await getTemporaryDirectory();
      final filePath = '${tempDir.path}/${imageUrl.split('/').last}';
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      return XFile(filePath);
    } else {
      print('Failed to download image. Status code: ${response.statusCode}');
      return null;
    }
  }

  static Future<dynamic> updateStory({required String token, XFile? image,required String description, required int id}) async {
    var request = http.MultipartRequest('PUT', Uri.parse(apiUrl.baseURL + '/institution/story/$id'))
      ..headers['x-auth-token'] = token
      ..fields.addAll({
        'description': description,
    });
    if(image!=null){
      request.files.add(await http.MultipartFile.fromPath('banner_image', image.path, contentType: MediaType('image', 'jpeg')));
    }
    var response = await request.send();
    var responseData = await http.Response.fromStream(response);
    return json.decode(responseData.body);
  }
}