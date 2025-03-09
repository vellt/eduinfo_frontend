import 'package:eduinfo/models/institution.dart';
import 'package:eduinfo/models/story.dart';
import 'package:eduinfo/services/api_service.dart' as api;

class StroyWithInstitution extends Story {
  final Institution institution;
  

  // Konstruktor
  StroyWithInstitution({
    required int id,
    required String description,
    required int likes,
    required String formattedDate,
    String? bannerImage,
    required this.institution,
    required liked,
  }) : super(
          id: id,
          description: description,
          likes: likes,
          formattedDate: formattedDate,
          bannerImage: bannerImage,
          liked: liked
        );
  
  factory StroyWithInstitution.fromJson(Map<String, dynamic> json) {
    return StroyWithInstitution(
      id: json['story_id'],
      description: json['description'],
      likes: json['likes'],
      formattedDate: json['formatted_datetime'],
      bannerImage: json['banner_image'] == null ? null : api.imageUrl + json['banner_image'],
      institution: Institution.fromJsonOfStories(json['institution_profile']),
      liked: json['liked'],
    );
  }
}