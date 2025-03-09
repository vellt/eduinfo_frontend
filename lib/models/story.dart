import 'package:eduinfo/services/api_service.dart' as api;
class Story {
  int id;
  String description;
  int likes;
  String formattedDate;
  String? bannerImage;
  bool liked;

  Story({
    required this.id, 
    required this.description, 
    required this.likes, 
    required this.formattedDate, 
    this.bannerImage, 
    required this.liked
  });


  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      id: json['story_id'],
      description: json['description'],
      likes: json['likes'],
      formattedDate: json['formatted_datetime'],
      liked: json.containsKey('liked') ? json['liked'] : false,
      bannerImage: json['banner_image']==null?null: api.imageUrl+json['banner_image'],
    );
  }
}