import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:eduinfo/services/api_service.dart' as apiUrl;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class CreateStoryNetwork {
  static Future<dynamic> createStory({required String token, XFile? image,required String description}) async {
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl.baseURL + '/institution/story/'))
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