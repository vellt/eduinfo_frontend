import 'package:eduinfo/models/institution.dart';
import 'package:eduinfo/models/institution_event.dart';
import 'package:eduinfo/models/event_link.dart';
import 'package:eduinfo/services/api_service.dart' as api;

class InstitutionEventWithInstitution extends InstitutionEvent {
  final Institution institution;

  InstitutionEventWithInstitution({
    required int id,
    required String title,
    required String location,
    required String description,
    required int interestedCount,
    required bool interested,
    String? bannerImage,
    required String month,
    required int day,
    required String time,
    required List<EventLink> links,
    required DateTime start,
    required DateTime end,
    required this.institution,
  }) : super(
          id: id,
          title: title,
          location: location,
          description: description,
          interestedCount: interestedCount,
          bannerImage: bannerImage,
          month: month,
          interested: interested,
          day: day,
          time: time,
          links: links,
          start: start,
          end: end,
        );
  
  factory InstitutionEventWithInstitution.fromJson(Map<String, dynamic> json) {
    return InstitutionEventWithInstitution(
      id: json['event_id'],
      title: json['title'],
      location: json['location'],
      description: json['description'],
      interestedCount: json['interested_count'],
      interested: json['interested'],
      bannerImage: json['banner_image']==null?null: api.imageUrl+json['banner_image'],
      month: json['month'],
      day: json['day'],
      time: json['time'],
      start:DateTime.parse(json['start']).toLocal(),
      end: DateTime.parse(json['end']).toLocal(),
      links: (json['event_links'] as List).map((item)=>EventLink.fromJson(item)).toList(),
      institution: Institution.fromJsonOfEvents(json['institution_profile']),
    );
  }
}