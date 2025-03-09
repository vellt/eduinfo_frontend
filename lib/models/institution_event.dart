import 'package:eduinfo/models/event_link.dart';
import 'package:eduinfo/services/api_service.dart' as api;

class InstitutionEvent {
  int id;
  String title;
  String location;
  String description;
  int interestedCount;
  bool interested;
  String? bannerImage;
  String month;
  int day;
  String time;
  List<EventLink> links;
  DateTime start;
  DateTime end;

  InstitutionEvent({
    required this.id, 
    required this.title, 
    required this.location, 
    required this.description,
    required this.interestedCount,
    required this.bannerImage,
    required this.month,
    required this.day,
    required this.time,
    required this.links,
    required this.start,
    required this.end,
    required this.interested,
  });

  factory InstitutionEvent.fromJsonOfInstitution(Map<String, dynamic> json) {
    return InstitutionEvent(
      id: json['event_id'],
      title: json['title'],
      location: json['location'],
      description: json['description'],
      interestedCount: json['interested_count'],
      bannerImage: json['banner_image']==null?null: api.imageUrl+json['banner_image'],
      month: json['month'],
      day: json['day'],
      time: json['time'],
      interested: false,
      start: DateTime.parse(json['start']).toLocal(),
      end: DateTime.parse(json['end']).toLocal(),
      links: (json['event_links'] as List).map((item)=>EventLink.fromJson(item)).toList(),
    );
  }

  factory InstitutionEvent.fromJsonOfPerson(Map<String, dynamic> json) {
    return InstitutionEvent(
      id: json['event_id'],
      title: json['title'],
      location: json['location'],
      description: json['description'],
      interestedCount: json['interested_count'],
      bannerImage: json['banner_image']==null?null: api.imageUrl+json['banner_image'],
      month: json['month'],
      day: json['day'],
      time: json['time'],
      interested: json['interested'],
      start: DateTime.parse(json['start']).toLocal(),
      end: DateTime.parse(json['end']).toLocal(),
      links: (json['event_links'] as List).map((item)=>EventLink.fromJson(item)).toList(),
    );
  }
}